Yes, but go in steps.

Dev dependencies non breaking patch
Dev dependencies non breaking minor
Dev dependencies breaking major
Dependencies non breaking patch
Dependencies non breaking minor
Dependencies breaking major
And you can use different commits for anything that are related, like eslint related packages, etc.

Also remove overrides and use pn clean and recheck if there are any overrides left.
For each iteration there should be another check to see changes in terminal via AI and see if there is breaking change or action needed or not.
