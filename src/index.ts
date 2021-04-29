import { init_maps } from "./maps";
import { init_options } from "./options";
import { init_plugins } from "./plugins";

vim.g.mapleader = " ";
vim.g.maplocalleader = " ";

init_maps();
init_options();
init_plugins();