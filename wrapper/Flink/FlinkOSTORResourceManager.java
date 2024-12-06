{\rtf1\ansi\ansicpg936\cocoartf2820
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 package com.ostor.wrapper.flink;\
\
import org.apache.flink.runtime.resourcemanager.ResourceManager;\
import com.ostor.wrapper.common.OSTORConfig;\
import com.ostor.wrapper.common.OSTOROptimizer;\
\
public class FlinkOSTORResourceManager extends ResourceManager \{\
    private final OSTORConfig config;\
    private final OSTOROptimizer optimizer;\
    private final MetricsCollector metricsCollector;\
\
    public FlinkOSTORResourceManager(OSTORConfig config) \{\
        this.config = config;\
        this.optimizer = new OSTOROptimizer(config);\
        this.metricsCollector = new MetricsCollector();\
    \}\
\
    @Override\
    protected void initialize() \{\
        super.initialize();\
        startResourceMonitoring();\
    \}\
\
    private void startResourceMonitoring() \{\
        if (config.getResourceMode() == ResourceMode.ADAPTIVE) \{\
            getMainThreadExecutor().scheduleAtFixedRate(\
                this::performAdaptiveOptimization,\
                0,\
                config.getWindowSize(),\
                TimeUnit.MILLISECONDS\
            );\
        \}\
    \}\
\
    private void performAdaptiveOptimization() \{\
        Map<String, Double> metrics = metricsCollector.collectMetrics();\
        OptimizationResult result = optimizer.optimize(metrics);\
        applyOptimizationResult(result);\
    \}\
\
    private void applyOptimizationResult(OptimizationResult result) \{\
        // Implement resource adjustment logic\
    \}\
\}}