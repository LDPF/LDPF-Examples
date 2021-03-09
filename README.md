# LDPF - Lua GUI for DISTRHO Plugin Framework


LDPF is an extension for [DPF] (DISTRHO Plugin Framework) that makes it 
possible to implement the GUI of audio plugins using the [Lua] scripting language.

This repository contains example plugins and demonstrates the usage of LDPF.

* [ldpf-example01] simple mute/unmute plugin using [LPugl] Gui with the [Cairo] backend.
* [ldpf-example02] simple mute/unmute plugin using [LPugl] Gui with [lua-nanovg] for
   rendering to the OpenGL backend.

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
  that are listed in the [toplevel Makefile]. The plugins will be statically
  linked to these components. For Windows and MacOS these components include 
  [Cairo]  and related libraries (pixman, libpng and zlib). For Linux these 
  libraries are taken from the system installation, i.e. the plugins are linked 
  dynamically to these libraries.

* Build the plugins. You may use the `-jN` option to speed up build time by using N processes in parallel, e.g.

  ```shell
  $ make -j4
  ```

* As with normal DPF plugins the build results are in the directory `./bin`
  

[DPF]:               https://github.com/DISTRHO/DPF
[ldpf-example01]:    ./plugins/example01/
[ldpf-example02]:    ./plugins/example02/
[LPugl]:             https://github.com/osch/lua-lpugl
[lua-nanovg]:        https://github.com/starwing/lua-nanovg
[Lua]:               https://www.lua.org/
[GNU-Make]:          https://www.gnu.org/software/make/
[MSYS2]:             https://www.msys2.org/
[brew]:              https://brew.sh/
[toplevel Makefile]: ./Makefile
[Cairo]:             https://www.cairographics.org/
[config.mk]:         ./config.mk


