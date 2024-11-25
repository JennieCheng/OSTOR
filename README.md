# OSTOR Implementation and Corresponding Experiments

This repository contains the implementation of OSTOR and corresponding experiments.

## Repository Structure

### Algorithm Implementation (`/algorithm`)

- `adaptive_dual_descent_algorithm.m`: Implementation of the Adaptive Dual Descent algorithm for the scheduling optimization
- `ostor.m`: OSTOR algorithm implementation
- `reactivate.m`: Query reactivation strategy
- `reassign.m`: Plan reassignment strategy
- `tradition1.m`: First baseline traditional scheduling approach
- `tradition2.m`: Second baseline traditional scheduling approach

### Experiments (`/experiments`)

Experimental validation files corresponding to results presented in the paper:

- `test_online_socialwelfare_exp1.m`: Online social welfare optimization experiment (Experiment 1)
- `test_plan_sw_exp2.m`: Plan-based social welfare evaluation experiment (Experiment 2)
- `test_query_sw_exp3.m`: Query-based social welfare analysis experiment (Experiment 3)
- `test_query_cost_exp4.m`: Query cost analysis experiment (Experiment 4)
- `test_budget_sw_exp5.m`: Budget impact on social welfare experiment (Experiment 5)
- `test_ablation_exp6.m`: Ablation study experiment (Experiment 6)


## Requirements

- MATLAB R2020a or later

## Usage

1. Clone this repository
2. Add both `algorithm` and `experiments` folders to MATLAB path
3. Run individual experiment files to reproduce results
