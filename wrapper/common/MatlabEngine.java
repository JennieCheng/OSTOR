package com.ostor.wrapper.common;

import com.mathworks.engine.MatlabEngine;
import java.util.concurrent.Future;

public class MatlabEngine {
    private static MatlabEngine engine;
    private final OSTORConfig config;

    public MatlabEngine(OSTORConfig config) {
        this.config = config;
    }

    public synchronized void initialize() throws Exception {
        if (engine == null) {
            engine = MatlabEngine.startMatlab();
            engine.addPath(config.getMatlabPath() + "/ostor/algorithm");
        }
    }

    public Future<Object[]> runOSTOROptimization(
            double[] utilities,
            double[] costs,
            double budget,
            boolean isAdaptive) throws Exception {
        
        initialize();
        return engine.feval(4, "ostor",
                utilities,
                costs,
                budget,
                isAdaptive);
    }

    public void close() {
        if (engine != null) {
            engine.close();
            engine = null;
        }
    }
}