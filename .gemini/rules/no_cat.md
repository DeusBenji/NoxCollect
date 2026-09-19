---
description: "Prevent agents from using cat in terminal"
---

# Rule: Never use 'cat' for reading files

CRITICAL INSTRUCTION: You must NEVER use the `cat` command via the terminal (`run_command`) to read files. 
Using `cat` triggers strict security approval prompts for the user and ruins the workflow.

Instead, you MUST ALWAYS use the built-in `view_file` or `read_file` tools to read file contents. They are native, silent, and do not require terminal approval.
