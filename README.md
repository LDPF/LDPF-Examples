# LDPF - Lua GUI for DISTRHO Plugin Framework


LDPF is an extension for [DPF] (DISTRHO Plugin Framework) that makes it 
possible to implement the GUI of audio plugins using the [Lua] scripting language.

This repository contains example plugins and demonstrates the usage of LDPF.

* [ldpf-example01] mute/unmute plugin using [LPugl] Gui with the [Cairo] backend.
* [ldpf-example02] mute/unmute plugin using [LPugl] Gui with [lua-nanovg] for
   rendering to the OpenGL backend.
* [ldpf-example03] mute/unmute plugin demonstrating simple [lwtk] widgets using [ldpfgui].

The first two examples are using the very low level basic *ldpf* api.
The third example uses the more comfortable [ldpfgui] api which is a wrapper 
around the low level *ldpf* api and is an extension to [lwtk] (*Lua Widget Toolkit*).

## Introduction

The example plugins have been tested under Linux, Windows and MacOS. However
LDPF is still work in progress and not every possible functionality is implemented
and/or tested yet.

To build the examples plugins you need typical GNU build tools e.g.
C-Compiler and [GNU-Make]. Windows build has been tested using [MSYS2]. For MacOS [brew] has been used.

* Checkout the repository:

  ```shell
  $ git clone --recurse-submodules git@github.com:LDPF/LDPF-Examples.git
  ```

* Download thirdparty source code for required components:

  ```shell
  $ cd LDPF-Examples
  $ make download-components
  ```
  
  This downloads source code for the components that are needed for the plugins
  that are listed in the [toplevel Makefile]. 
  
  The plugins will be statically linked to these components. For Windows and
  MacOS these components include  [Cairo]  and related libraries (pixman, libpng
  and zlib). For Linux these  libraries are taken from the system installation,
  i.e. the plugins are linked  dynamically to these libraries.
  
  All possible components have to be listed in [config.mk], but only the components
  that are needed for the plugins listed in the toplevel Makefile are downloaded.
  This is calculated from the listed dependencies in files called `info.mk` in 
  each plugin's/component's directory.

  The needed component's source code is downloaded to the directory 
  `thirdparty/$COMPONENT_NAME`. The download for a component is skipped if 
  this directory already exists. Some components don't need a download (e.g. 
  [ldpfgui] has its source code included; [lpugl_cairo] and [lpugl_openl]
  are sharing the source code with [component lpugl]).

* Build the plugins. You may use the `-jN` option to speed up build time by using N processes in parallel, e.g.

  ```shell
  $ make -j4
  ```

* As with normal DPF plugins the build results are in the directory `./bin`
  

[DPF]:                   https://github.com/DISTRHO/DPF
[ldpf-example01]:        ./plugins/example01/
[ldpf-example02]:        ./plugins/example02/
[ldpf-example03]:        ./plugins/example03/
[LPugl]:                 https://github.com/osch/lua-lpugl
[lwtk]:                  https://github.com/osch/lua-lwtk
[lua-nanovg]:            https://github.com/starwing/lua-nanovg
[Lua]:                   https://www.lua.org/
[GNU-Make]:              https://www.gnu.org/software/make/
[MSYS2]:                 https://www.msys2.org/
[brew]:                  https://brew.sh/
[toplevel Makefile]:     ./Makefile
[Cairo]:                 https://www.cairographics.org/
[config.mk]:             ./config.mk
[ldpfgui]:               https://github.com/LDPF/LDPF/tree/master/components/ldpfgui
[component lpugl]:       https://github.com/LDPF/LDPF/tree/master/components/lpugl
[lpugl_cairo]:           https://github.com/LDPF/LDPF/tree/master/components/lpugl_cairo
[lpugl_openl]:           https://github.com/LDPF/LDPF/tree/master/components/lpugl_opengl
