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

#include "DistrhoPlugin.hpp"

#include <string.h>

START_NAMESPACE_DISTRHO

class Example02Plugin : public Plugin
{
public:
    enum ParameterIndex {
        MUTE = 0,
        PARAM_COUNT
    };

    Example02Plugin()
        : Plugin(PARAM_COUNT,
                 0, // programCount
                 0) // stateCount
    {
        parameterValue[MUTE] = 0;
    }

    void initParameter(uint32_t index, Parameter& parameter)
    {
        switch (index) {
            case MUTE: {
                parameter.hints = kParameterIsBoolean|kParameterIsAutomable;
                parameter.ranges.min = 0;
                parameter.ranges.max = 1;
                parameter.ranges.def = 0;
                parameter.name = "Mute";
                break;
            }
        }
        parameter.symbol = parameter.name;
    }

    const char* getLabel() const
    {
        return "LDPF Example01";
    }

    const char* getMaker() const
    {
        return "Oliver Schmidt";
    }

    const char* getLicense() const
    {
        return "ISC";
    }

    uint32_t getVersion() const
    {
        return 0;
    }

    int64_t getUniqueId() const
    {
        return  d_cconst('l', 'd', '0', '2');
    }

    float getParameterValue(uint32_t index) const
    {
        return parameterValue[index];
    }

    void setParameterValue(uint32_t index, float value)
    {
        parameterValue[index] = value;
    }

    void initState(uint32_t index, String& stateKey, String& defaultStateValue) 
    {
    }
    void setState(const char* key, const char* value)
    {
    }
    void initProgramName(uint32_t index, String& programName)
    {
    }
    void loadProgram(uint32_t index)
    {
    }
    String getState(const char* key) const
    {
        return String("");
    }
    
    void run(const float** inputs, float** outputs, uint32_t frames)
    {
        if (parameterValue[MUTE]) {
            memset(outputs[0], 0, frames * sizeof(float));
            memset(outputs[1], 0, frames * sizeof(float));
        } else {
            memcpy(outputs[0], inputs[0], frames * sizeof(float));
            memcpy(outputs[1], inputs[1], frames * sizeof(float));
        }
    }

private:
    float parameterValue[PARAM_COUNT];
};

Plugin* createPlugin()
{
    return new Example02Plugin();
}

END_NAMESPACE_DISTRHO
