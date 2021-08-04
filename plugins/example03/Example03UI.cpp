/*
 * DISTRHO Plugin Framework (DPF)
 * Copyright (C) 2012-2019 Filipe Coelho <falktx@falktx.com>
 *
 * Permission to use, copy, modify, and/or distribute this software for any purpose with
 * or without fee is hereby granted, provided that the above copyright notice and this
 * permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD
 * TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN
 * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 * DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER
 * IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include "../../ldpf/ldgl/LuaInitParams.hpp"

// -----------------------------------------------------------------------
START_NAMESPACE_LDGL
// -----------------------------------------------------------------------

/**
 *  Initial parameters to be provided by PluginUI.
 */
static LuaInitParams initParams(
    /**
     * Lua modules path for overriding builtin Lua modules for debugging purposes.
     */
#ifdef LDPF_EXAMPLE03_LUA_PATH
    LDPF_EXAMPLE03_LUA_PATH,
#else
    NULL,
#endif

    /**
     * Name of environmant variable for Lua modules path for overriding builtin 
     * Lua modules for debugging purposes or NULL if such environment variable
     * should not be evaluated.
     */
    "LDPF_EXAMPLE03_LUA_PATH"
);

/**
 *  This function has to be implemented by PluginUI.
 */
LuaInitParams* getLuaInitParams()
{
        printf("=============== LuaExamplUI run\n");
    return &initParams;
}

// -----------------------------------------------------------------------
END_NAMESPACE_LDGL
// -----------------------------------------------------------------------
