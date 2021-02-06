type _map = { [key: string]: any };

declare module "*!text" {
  const content: string;
  export default content;
}

declare namespace vim {
  // 变量
  var g: _map;
  var b: _map;
  var w: _map;
  var t: _map;
  var v: _map;
  // options
  var o: _map;
  var bo: _map;
  var wo: _map;

  var fn: {
    [key: string]: (this: void, ...args: any[]) => any;
  };

  function split(path: string, s: string): any;

  function cmd(cmd: string): void;

  namespace api {
    function nvim_exec(cmd: string, is_output: boolean): void;

    interface KeymapOptions {
      buffer?: boolean;
      nowait?: boolean;
      silent?: boolean;
      script?: boolean;
      expr?: boolean;
      unique?: boolean;
    }

    function nvim_set_keymap(
      type: string,
      key: string,
      value: string,
      options: KeymapOptions
    ): void;

    function nvim_buf_set_keymap(
      buf_num: number,
      type: string,
      key: string,
      value: string,
      options: KeymapOptions
    ): void;

    function nvim_set_option(key: string, value: any): void;
    function nvim_buf_set_option(
      buf_num: number,
      key: string,
      value: any
    ): void;
    function nvim_win_set_option(
      win_num: number,
      key: string,
      value: any
    ): void;

    function nvim_buf_get_option(buf_num: number, type: string): any;

    function nvim_buf_is_valid(buf_num: number): boolean;

    function nvim_list_bufs(): number[];

    function nvim_get_current_buf(): number;
  }
}

interface Packer {
  init: (this: void, args: Object) => void;
  use: (this: void, args: Array<any>) => void;
}

interface Bufferline {
  setup: (this: void, args: Object) => void;
}

interface LspConfig {
  [key: string]: {
    setup: (this: void, args: Object) => void;
  };
}
