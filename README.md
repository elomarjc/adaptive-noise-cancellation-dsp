# 🫀 Active Adaptive Noise Cancellation (ANC) for Physiological Stethoscope Signals

<div align="center">

# Active Adaptive Noise Cancellation (ANC)
### Master's Thesis Project • Electronic Systems (Advanced Signal Processing)
**Aalborg University (AAU) • Department of Electronic Systems**

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](https://mathworks.com)
[![Domain](https://img.shields.io/badge/Domain-Digital_Signal_Processing-blue?style=for-the-badge)](https://github.com/elomarjc)
[![Algorithms](https://img.shields.io/badge/Algorithms-LMS_%7C_NLMS_%7C_RLS-darkgreen?style=for-the-badge)](https://github.com/elomarjc)
[![Academic](https://img.shields.io/badge/AAU-Electronic_Systems-0C2340?style=for-the-badge)](https://www.aau.dk)

</div>

---

## 📋 Overview & Problem Formulation

Acoustic stethoscopes and digital phonocardiography devices are critical non-invasive diagnostic instruments for detecting valvular heart defects, murmurs, and abnormal physiological rhythms. However, real-world auscultation is severely degraded by ambient clinical acoustic interference (speech, medical equipment alarms, movement artifacts, and hospital environmental noise).

This project presents the design, mathematical formulation, simulation, and empirical benchmarking of **Active Adaptive Noise Cancellation (ANC)** systems tailored specifically for physiological acoustic recordings.

By employing dual-sensor acoustic configurations and adaptive finite impulse response (FIR) filtering architectures, the system dynamically estimates and subtracts correlated acoustic noise in real time while preserving low-frequency cardiac components ($S_1$, $S_2$ transients and murmurs between 20 Hz – 500 Hz).

---

## 🔬 Mathematical Formulation & Filter Architectures

```
     Primary Input d(n) = s(n) + n0(n) ───────────(+)──────────► Error Signal e(n) ≈ s(n)
     (Desired signal + Acoustic noise)              ▲              (Filtered Cardiac Audio)
                                                    │ -y(n)
                                            ┌───────┴────────┐
     Reference Input x(n) ─────────────────►│ Adaptive Filter │
     (Correlated ambient noise)             │      W(n)      │
                                            └───────┬────────┘
                                                    ▲
                                                    │ Adaptation Step
                                                    └─────────────── e(n)
```

Three classical adaptive filtering formulations were implemented, analyzed, and evaluated:

### 1. Least Mean Squares (LMS)
Stochastic gradient descent minimizing instantaneous mean square error:
$$e(n) = d(n) - \mathbf{w}^T(n)\mathbf{x}(n)$$
$$\mathbf{w}(n+1) = \mathbf{w}(n) + 2\mu e(n)\mathbf{x}(n)$$
* **Characteristics**: Low computational complexity $\mathcal{O}(L)$, stable under stationary statistics, sensitive to input signal power scaling.

### 2. Normalized Least Mean Squares (NLMS)
Normalizes the adaptation step size by the Euclidean norm of the reference vector to prevent gradient divergence during high-energy acoustic bursts:
$$\mathbf{w}(n+1) = \mathbf{w}(n) + \frac{\mu}{\|\mathbf{x}(n)\|^2 + \epsilon} e(n)\mathbf{x}(n)$$
* **Characteristics**: Resilient against non-stationary speech and environmental volume swings.

### 3. Recursive Least Squares (RLS)
Deterministic Gauss-Newton minimization with an exponential weighting forgetting factor $\lambda$:
$$\mathbf{k}(n) = \frac{\mathbf{P}(n-1)\mathbf{x}(n)}{\lambda + \mathbf{x}^T(n)\mathbf{P}(n-1)\mathbf{x}(n)}$$
$$e(n) = d(n) - \mathbf{w}^T(n-1)\mathbf{x}(n)$$
$$\mathbf{w}(n) = \mathbf{w}(n-1) + \mathbf{k}(n)e(n)$$
$$\mathbf{P}(n) = \frac{1}{\lambda}\left[\mathbf{P}(n-1) - \mathbf{k}(n)\mathbf{x}^T(n)\mathbf{P}(n-1)\right]$$
* **Characteristics**: Extremely rapid convergence rates independent of eigenvalue spread, $\mathcal{O}(L^2)$ computational complexity.

---

## 📊 Experimental Framework & Benchmark Results

The algorithms were evaluated across four progressive testing stages to quantify Signal-to-Noise Ratio (SNR) enhancement:

| Experiment Setup | Input Noise Level | Post-LMS SNR | Post-NLMS SNR | Post-RLS SNR | Max Improvement |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **1. Baseline Sinusoidal Wave** | -20.02 dB | +3.25 dB | **+129.30 dB** | +113.32 dB | **+149.32 dB** |
| **2. Synthetic Heartbeat Signal** | -20.00 dB | +5.82 dB | **+101.76 dB** | +91.62 dB | **+121.76 dB** |
| **3. Clinical Hospital Ambient Noise** | -0.27 dB | **+18.67 dB** | +16.69 dB | +16.67 dB | **+18.94 dB** |
| **4. Physical Acoustic Testbed** | -17.42 dB | **+23.43 dB** | +17.32 dB | +17.29 dB | **+40.85 dB** |

### Key Benchmark Insights
* **Deterministic Convergence**: In theoretical and synthetic environments with stationary noise transfer functions, **NLMS** and **RLS** achieved $>100\text{ dB}$ noise rejection.
* **Clinical Real-World Noise**: Under real non-stationary hospital ambient noise, **LMS and NLMS** demonstrated exceptional robustness, delivering up to **+40 dB SNR improvements** in physical acoustic testbed trials.
* **Perceptual Validation via Mel-Spectrograms**: Time-frequency spectral analysis confirmed that high-frequency acoustic hiss and ambient chatter were attenuated without distorting critical low-frequency physiological heart valve clicks ($S_1/S_2$).

---

## 📁 Repository Structure

```
new_adaptivefilter/
├── 1_Baseline_Sinus_Wave/          # Synthetic tone tests verifying algorithm convergence
├── 2_Baseline_Synthetic_Heartbeat/   # Simulated phonocardiogram signals with white Gaussian noise
├── 3_Baseline_Company_Data/         # Real acoustic evaluation with clinical hospital noise
├── 4_Baseline_My_Own_Experiment/     # Empirical physical acoustic chamber testbed recordings
├── Auditory Evaluation/             # Audio playback verification and listening test scripts
├── Mel_spectrogram/                 # Mel-frequency filter bank spectral visualizer
├── Spectrogram/                     # STFT time-frequency spectrogram plotting routines
├── Plots for technical chapter/     # High-resolution vector figures generated for thesis
├── SNR_comparison.m                 # Master benchmark comparison and grouped bar graph generator
└── SNR_comparison.pdf               # Output comparative SNR chart across all experiments
```

---

## 🚀 Getting Started (MATLAB)

### Prerequisites
* MATLAB R2022b or later
* Signal Processing Toolbox
* Audio Toolbox

### Running the SNR Comparison
```matlab
% Clone repository
git clone https://github.com/elomarjc/adaptive-noise-cancellation-dsp.git
cd adaptive-noise-cancellation-dsp

% Generate SNR comparative figure
run('SNR_comparison.m')
```

---

## 🎓 Academic Context & Credits

* **Author**: Jacob El-Omar
* **Degree**: M.Sc. in Electronic Systems (Specialization: Advanced Signal Processing)
* **Institution**: Aalborg University, Denmark (AAU)
* **Collaborator**: Ai Highway Inc (Acoustic data acquisition and clinical context)

> *This repository contains the mathematical simulation codebase and benchmarking scripts developed as part of the Master's Thesis research.*
