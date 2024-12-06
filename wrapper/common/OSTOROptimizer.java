{\rtf1\ansi\ansicpg936\cocoartf2820
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 package com.ostor.wrapper.common;\
\
import java.util.Map;\
import java.util.concurrent.Future;\
\
public class OSTOROptimizer \{\
    private final OSTORConfig config;\
    private final MatlabEngine matlab;\
\
    public OSTOROptimizer(OSTORConfig config) \{\
        this.config = config;\
        this.matlab = new MatlabEngine(config);\
    \}\
\
    public OptimizationResult optimize(Map<String, Double> metrics) \{\
        try \{\
            double[] utilities = convertToUtilities(metrics);\
            double[] costs = convertToCosts(metrics);\
\
            Future<Object[]> result = matlab.runOSTOROptimization(\
                utilities,\
                costs,\
                config.getBudgetConstraint(),\
                config.getResourceMode() == ResourceMode.ADAPTIVE\
            );\
\
            return processOptimizationResult(result.get());\
        \} catch (Exception e) \{\
            throw new RuntimeException("OSTOR optimization failed", e);\
        \}\
    \}\
\
    private double[] convertToUtilities(Map<String, Double> metrics) \{\
        // Convert system metrics to utility values\
        // Implementation based on paper's utility function\
        return new double[]\{\};  // Placeholder\
    \}\
\
    private double[] convertToCosts(Map<String, Double> metrics) \{\
        // Convert system metrics to cost values\
        // Implementation based on paper's cost model\
        return new double[]\{\};  // Placeholder\
    \}\
\
    private OptimizationResult processOptimizationResult(Object[] matlabResult) \{\
        // Process MATLAB output into OptimizationResult\
        return new OptimizationResult();  // Placeholder\
    \}\
\}\
\
class OptimizationResult \{\
    // Result data structure\
\}}