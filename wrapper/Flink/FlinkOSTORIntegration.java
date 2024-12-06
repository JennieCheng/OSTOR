package com.ostor.wrapper.flink;

import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import com.ostor.wrapper.common.OSTORConfig;

public class FlinkOSTORIntegration {
    public static void configure(StreamExecutionEnvironment env) {
        // Initialize OSTOR with default configuration
        OSTORConfig config = new OSTORConfig()
            .setResourceMode(ResourceMode.ADAPTIVE)
            .setMaxParallelism(10);
            
        // Attach OSTOR resource manager
        FlinkOSTORResourceManager resourceManager = new FlinkOSTORResourceManager(config);
        env.setResourceManager(resourceManager);
        
        // Enable dynamic scaling
        env.enableDynamicScaling(true);
        
        // Configure checkpointing for fault tolerance
        env.enableCheckpointing(1000); // checkpoint every second
    }
}