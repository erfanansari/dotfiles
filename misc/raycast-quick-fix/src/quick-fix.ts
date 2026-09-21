import { Clipboard, getPreferenceValues, getSelectedText, showHUD } from "@raycast/api";

const sleep = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

interface Preferences {
  groqApiKey: string;
  model?: string;
}

const SYSTEM_PROMPT = `You are a meticulous copy editor embedded in a text field.

Fix ONLY spelling, grammar, and punctuation mistakes in the user's text. Do not do anything else.

Strict rules:
- Preserve the author's tone, voice, register (casual/formal), and language. If the text is not in English, keep it in that language — do not translate.
- Preserve line breaks, paragraph breaks, and whitespace structure exactly as given.
- Never remove, alter, or "fix" @mentions, #channels, usernames, hashtags, emoji (unicode or :shortcode:), URLs, email addresses, file paths, code, inline code, or markdown syntax (*, _, \`, >, -, numbered lists, links). Copy these tokens through byte-for-byte.
- Do not rephrase, rewrite, shorten, expand, or "improve" wording beyond correcting actual errors. If a sentence is already correct, leave it untouched.
- Do not add or remove punctuation like exclamation marks for style, only fix genuine errors (missing periods, comma splices, wrong its/it's, etc).
- Do not add quotation marks around the output.
- Do not add any explanation, preamble, or commentary.
- If the input is empty, gibberish, code, or already correct, return it unchanged.

Return ONLY the corrected text, nothing else.`;

async function fixText(text: string, apiKey: string, model: string): Promise<string> {
  const response = await fetch("https://api.groq.com/openai/v1/chat/completions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model,
      temperature: 0,
      reasoning_effort: "low",
      messages: [
        { role: "system", content: SYSTEM_PROMPT },
        { role: "user", content: text },
      ],
    }),
  });

  if (!response.ok) {
    if (response.status === 401) {
      throw new Error("Invalid Groq API key");
    }
    if (response.status === 429) {
      throw new Error("Rate limited by Groq, try again shortly");
    }
    const body = await response.text().catch(() => "");
    throw new Error(`Groq request failed (${response.status}): ${body.slice(0, 200)}`);
  }

  const data = (await response.json()) as {
    choices?: { message?: { content?: string } }[];
  };

  const fixed = data.choices?.[0]?.message?.content;
  if (!fixed) {
    throw new Error("Groq returned an empty response");
  }

  return fixed.trim();
}

export default async function Command() {
  const preferences = getPreferenceValues<Preferences>();
  const model = preferences.model || "openai/gpt-oss-20b";

  let selectedText: string;
  try {
    selectedText = await getSelectedText();
  } catch {
    await showHUD("No text selected");
    return;
  }

  if (!selectedText || selectedText.trim().length === 0) {
    await showHUD("No text selected");
    return;
  }

  // Raycast falls back showToast to showHUD whenever the main window isn't
  // open (always true for a global-hotkey, no-view command), and mutating a
  // Toast's properties right before the process exits can be dropped. Two
  // sequential HUD calls are the reliable way to get the appear/fade pill.
  await showHUD("Fixing text…");

  try {
    const fixed = await fixText(selectedText, preferences.groqApiKey, model);

    if (fixed === selectedText) {
      await showHUD("Already correct.");
      return;
    }

    const originalClipboard = await Clipboard.readText().catch(() => undefined);
    await Clipboard.paste(fixed);

    // Give the paste keystroke a moment to land before restoring the
    // clipboard, otherwise the restore can race the paste and it grabs the
    // old clipboard contents instead of the fixed text.
    if (originalClipboard !== undefined) {
      await sleep(300);
      await Clipboard.copy(originalClipboard).catch(() => undefined);
    }

    await showHUD("Fixed.");
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    await showHUD(message);
  }
}
