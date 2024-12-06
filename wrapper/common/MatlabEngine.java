{\rtf1\ansi\ansicpg936\cocoartf2820
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 package com.ostor.wrapper.common;\
\
import com.mathworks.engine.MatlabEngine;\
import java.util.concurrent.Future;\
\
public class MatlabEngine \{\
    private static MatlabEngine engine;\
    private final OSTORConfig config;\
\
    public MatlabEngine(OSTORConfig config) \{\
        this.config = config;\
    \}\
\
    public synchronized void initialize() throws Exception \{\
        if (engine == null) \{\
            engine = MatlabEngine.startMatlab();\
            engine.addPath(config.getMatlabPath() + "/ostor/algorithm");\
        \}\
    \}\
\
    public Future<Object[]> runOSTOROptimization(\
            double[] utilities,\
            double[] costs,\
            double budget,\
            boolean isAdaptive) throws Exception \{\
        \
        initialize();\
        return engine.feval(4, "ostor",\
                utilities,\
                costs,\
                budget,\
                isAdaptive);\
    \}\
\
    public void close() \{\
        if (engine != null) \{\
            engine.close();\
            engine = null;\
        \}\
    \}\
\}}