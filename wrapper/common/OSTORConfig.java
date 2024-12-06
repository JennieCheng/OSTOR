package com.ostor.wrapper.common;

public class OSTORConfig {
    private ResourceMode resourceMode;
    private int maxParallelism;
    private double learningRate;
    private int windowSize;
    private double budgetConstraint;
    private String matlabPath;

    public OSTORConfig() {
        // Default values
        this.resourceMode = ResourceMode.ADAPTIVE;
        this.maxParallelism = 10;
        this.learningRate = 0.7;
        this.windowSize = 100;
        this.budgetConstraint = 1000.0;
        this.matlabPath = "/usr/local/MATLAB/R2023b";
    }

    // Builder pattern setters
    public OSTORConfig setResourceMode(ResourceMode mode) {
        this.resourceMode = mode;
        return this;
    }

    public OSTORConfig setMaxParallelism(int parallelism) {
        this.maxParallelism = parallelism;
        return this;
    }

    public OSTORConfig setLearningRate(double rate) {
        this.learningRate = rate;
        return this;
    }

    public OSTORConfig setWindowSize(int size) {
        this.windowSize = size;
        return this;
    }

    public OSTORConfig setBudgetConstraint(double budget) {
        this.budgetConstraint = budget;
        return this;
    }

    public OSTORConfig setMatlabPath(String path) {
        this.matlabPath = path;
        return this;
    }

    // Getters
    public ResourceMode getResourceMode() { return resourceMode; }
    public int getMaxParallelism() { return maxParallelism; }
    public double getLearningRate() { return learningRate; }
    public int getWindowSize() { return windowSize; }
    public double getBudgetConstraint() { return budgetConstraint; }
    public String getMatlabPath() { return matlabPath; }
}

enum ResourceMode {
    STATIC, ADAPTIVE
}