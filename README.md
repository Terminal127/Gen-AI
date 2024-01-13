<img align=center src="https://github.com/Terminal127/nvim_gemini_plugin/blob/main/genai-high-resolution-logo-transparent.png" width=600 height=300>

This is a neovim plugin which using Lua. It is just made for fun and dont take it as a full fleged project but feel free to contribute.


## Deployment

To deploy this project run
Remember it is advisible to use virtual environment for this use.

```bash
  git clone https://github.com/Terminal127/nvim_gemini_plugin
  cd nvim_gemini_plugin
```


## API Reference

#### Get all items

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |



## Features

- ai plugin which uses gemini for its work
- uses plenary
- cmd usage :Gemini


## Usage/Examples

```lua
    remember to enter your API key in the ai.lua file.
    append the contents of the init.lua to your existing init.lua file.(Enter your api key in this state)
    copy the ai.lua file in your lua folder of /path/to/your_nvim_config_file

```


#
[![GNU License](https://img.shields.io/badge/License-GNU-green.svg)](https://choosealicense.com/licenses/gnu/)

