{\rtf1\ansi\ansicpg936\cocoartf2820
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 package com.ostor.wrapper.storm;\
\
import org.apache.storm.Config;\
import org.apache.storm.topology.TopologyBuilder;\
import com.ostor.wrapper.common.OSTORConfig;\
\
public class StormOSTORIntegration \{\
    public static void configure(TopologyBuilder builder) \{\
        Config conf = new Config();\
        \
        // Set OSTOR as resource manager and scheduler\
        conf.put(Config.TOPOLOGY_RAS_MANAGER, \
                "com.ostor.wrapper.storm.StormOSTORResourceManager");\
        conf.put(Config.TOPOLOGY_SCHEDULER_STRATEGY,\
                "com.ostor.wrapper.storm.StormOSTORScheduler");\
        \
        // Configure OSTOR parameters\
        conf.put("ostor.mode", "ADAPTIVE");\
        conf.put("ostor.learning.rate", 0.7);\
        conf.put("ostor.window.size", 100);\
        conf.put("ostor.budget.constraint", 1000.0);\
        \
        builder.setConfig(conf);\
    \}\
\}}