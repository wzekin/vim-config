import { init_maps } from "./maps";
import { init_options } from "./options";
import { init_plugins } from "./plugins";
import "./global";

vim.g.mapleader = " ";
vim.g.maplocalleader = " ";

init_maps();
init_options();
init_plugins();

if (os.getenv("IS_WSL") == "1") {
  vim.g.clipboard = {
    name: "myClipboard",
    copy: {
      "+": "win32yank.exe -i",
      "*": "win32yank.exe -i",
    },
    paste: {
      "+": "win32yank.exe -o --lf",
      "*": "win32yank.exe -o --lf",
    },

    cache_enabled: 1,
  };
}
