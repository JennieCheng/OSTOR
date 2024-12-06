package com.ostor.wrapper.storm;

import org.apache.storm.Config;
import org.apache.storm.topology.TopologyBuilder;
import com.ostor.wrapper.common.OSTORConfig;

public class StormOSTORIntegration {
    public static void configure(TopologyBuilder builder) {
        Config conf = new Config();
        
        // Set OSTOR as resource manager and scheduler
        conf.put(Config.TOPOLOGY_RAS_MANAGER, 
                "com.ostor.wrapper.storm.StormOSTORResourceManager");
        conf.put(Config.TOPOLOGY_SCHEDULER_STRATEGY,
                "com.ostor.wrapper.storm.StormOSTORScheduler");
        
        // Configure OSTOR parameters
        conf.put("ostor.mode", "ADAPTIVE");
        conf.put("ostor.learning.rate", 0.7);
        conf.put("ostor.window.size", 100);
        conf.put("ostor.budget.constraint", 1000.0);
        
        builder.setConfig(conf);
    }
}