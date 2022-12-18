GARCH(1,1) and Index Returns
____________________________________________________

Description:
________________________

This program analyzes the performance and accuracy of a GARCH(1,1) model for index returns through implementing, estimating and verifying the model for S&P 500 daily returns. In detail, it contains the following functionalities:

- Custom function for GARCH(1,1) estimation through Maximum-Likelihood Estimation
- Application of the GARCH(1,1) estimation on 15 years of S&P 500 daily returns
- Simulation of a 95% confidence interval for a 30 day prediction period across the full sample
- Verification of the confidence interval violations by the 30-day ahead return realizations

Program structure:
________________________

├── README
├── main.m
├── garchFit.m
├── garchObjective.m
├── garchCheck.m
├── plotTs.m
├── plotAcf.m
├── plotPacf.m
└── Figures
    ├── …

How to run the program:
________________________

Navigate to the file „main.m“ and run it.

Dependencies:
________________________

Econometrics Toolbox, Optimization Toolbox
