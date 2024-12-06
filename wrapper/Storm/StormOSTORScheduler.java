{\rtf1\ansi\ansicpg936\cocoartf2820
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 package com.ostor.wrapper.storm;\
\
import org.apache.storm.scheduler.IScheduler;\
import org.apache.storm.scheduler.Cluster;\
import org.apache.storm.scheduler.Topologies;\
import org.apache.storm.scheduler.TopologyDetails;\
import org.apache.storm.scheduler.ExecutorDetails;\
import org.apache.storm.scheduler.WorkerSlot;\
import com.ostor.wrapper.common.OSTORConfig;\
import com.ostor.wrapper.common.OSTOROptimizer;\
\
import java.util.*;\
\
public class StormOSTORScheduler implements IScheduler \{\
    private OSTORConfig config;\
    private OSTOROptimizer optimizer;\
    private Map<String, Object> conf;\
\
    @Override\
    public void prepare(Map<String, Object> conf) \{\
        this.conf = conf;\
        this.config = loadConfig();\
        this.optimizer = new OSTOROptimizer(config);\
    \}\
\
    private OSTORConfig loadConfig() \{\
        return new OSTORConfig()\
            .setResourceMode(ResourceMode.valueOf((String) conf.getOrDefault("ostor.mode", "ADAPTIVE")))\
            .setLearningRate((Double) conf.getOrDefault("ostor.learning.rate", 0.7))\
            .setWindowSize((Integer) conf.getOrDefault("ostor.window.size", 100))\
            .setBudgetConstraint((Double) conf.getOrDefault("ostor.budget.constraint", 1000.0));\
    \}\
\
    @Override\
    public void schedule(Topologies topologies, Cluster cluster) \{\
        if (topologies.getTopologies().isEmpty()) \{\
            return;\
        \}\
\
        // Collect current system metrics\
        Map<String, Double> metrics = collectClusterMetrics(cluster);\
        \
        // Get optimization result\
        OptimizationResult result = optimizer.optimize(metrics);\
        \
        // Apply scheduling decisions\
        for (TopologyDetails topology : topologies.getTopologies()) \{\
            if (cluster.needsScheduling(topology)) \{\
                scheduleTopology(topology, cluster, result);\
            \}\
        \}\
    \}\
\
    private Map<String, Double> collectClusterMetrics(Cluster cluster) \{\
        Map<String, Double> metrics = new HashMap<>();\
        \
        // Collect supervisor metrics\
        for (SupervisorDetails supervisor : cluster.getSupervisors().values()) \{\
            metrics.put("cpu." + supervisor.getId(), \
                       getSupervisorCPUUsage(supervisor));\
            metrics.put("memory." + supervisor.getId(), \
                       getSupervisorMemoryUsage(supervisor));\
        \}\
        \
        // Collect topology metrics\
        for (TopologyDetails topology : cluster.getTopologies().getTopologies()) \{\
            metrics.put("throughput." + topology.getId(), \
                       getTopologyThroughput(topology));\
            metrics.put("latency." + topology.getId(), \
                       getTopologyLatency(topology));\
        \}\
        \
        return metrics;\
    \}\
\
    private void scheduleTopology(TopologyDetails topology, \
                                Cluster cluster, \
                                OptimizationResult result) \{\
        // Get unassigned executors\
        Collection<ExecutorDetails> unassignedExecutors = \
            cluster.getUnassignedExecutors(topology);\
        if (unassignedExecutors.isEmpty()) \{\
            return;\
        \}\
\
        // Get available slots based on optimization result\
        List<WorkerSlot> availableSlots = getAvailableSlots(cluster, result);\
        if (availableSlots.isEmpty()) \{\
            return;\
        \}\
\
        // Group executors by component\
        Map<String, List<ExecutorDetails>> componentToExecutors = \
            groupExecutorsByComponent(topology, unassignedExecutors);\
\
        // Schedule each component's executors\
        for (Map.Entry<String, List<ExecutorDetails>> entry : \
             componentToExecutors.entrySet()) \{\
            String component = entry.getKey();\
            List<ExecutorDetails> executors = entry.getValue();\
            \
            // Get optimal slots for this component based on optimization result\
            List<WorkerSlot> optimalSlots = \
                selectOptimalSlots(availableSlots, component, result);\
            \
            // Assign executors to slots\
            assignExecutorsToSlots(topology, executors, optimalSlots, cluster);\
        \}\
    \}\
\
    private List<WorkerSlot> getAvailableSlots(Cluster cluster, \
                                              OptimizationResult result) \{\
        List<WorkerSlot> availableSlots = new ArrayList<>();\
        \
        for (SupervisorDetails supervisor : cluster.getSupervisors().values()) \{\
            // Check if supervisor meets optimization constraints\
            if (meetsOptimizationConstraints(supervisor, result)) \{\
                availableSlots.addAll(cluster.getAvailableSlots(supervisor));\
            \}\
        \}\
        \
        return availableSlots;\
    \}\
\
    private void assignExecutorsToSlots(TopologyDetails topology,\
                                      List<ExecutorDetails> executors,\
                                      List<WorkerSlot> slots,\
                                      Cluster cluster) \{\
        if (executors.isEmpty() || slots.isEmpty()) \{\
            return;\
        \}\
\
        // Distribute executors across slots\
        int executorsPerSlot = \
            (int) Math.ceil((double) executors.size() / slots.size());\
        \
        int currentExecutor = 0;\
        for (WorkerSlot slot : slots) \{\
            if (currentExecutor >= executors.size()) \{\
                break;\
            \}\
\
            // Get executors for this slot\
            List<ExecutorDetails> slotExecutors = new ArrayList<>();\
            for (int i = 0; i < executorsPerSlot && currentExecutor < executors.size(); i++) \{\
                slotExecutors.add(executors.get(currentExecutor++));\
            \}\
\
            // Assign executors to slot\
            cluster.assign(slot, topology.getId(), slotExecutors);\
        \}\
    \}\
\
    @Override\
    public Map<String, Map<String, Double>> config() \{\
        // Return scheduler configuration details\
        return new HashMap<>();\
    \}\
\}}