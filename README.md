# mma-imt-absorbance-matlab

MATLAB script to compute the absorbance of a metamaterial absorber from CST-exported S-parameters using impedance matching theory. Companion code for a numerical study of a quad-resonant X- and Ku-band absorber.

## What it does

The script reads the real and imaginary parts of S11 and S21 exported from CST Studio Suite, retrieves the normalized impedance, and computes the absorbance with impedance matching theory. The result is plotted against frequency and saved to a file.

## Method

Normalized impedance retrieved from the S-parameters:

$$Z_n = \sqrt{\frac{(1+S_{11})^2 - S_{21}^2}{(1-S_{11})^2 - S_{21}^2}}$$

Effective impedance, reflection coefficient and absorbance, with $Z_0 = 377\ \Omega$:

$$Z = Z_0 Z_n, \qquad \Gamma = \frac{Z - Z_0}{Z + Z_0}, \qquad A = 1 - |\Gamma|^2$$

## Input format

A table exported from CST with one row per frequency point and these column headers:

| Column   | Description                      |
|----------|----------------------------------|
| `f_GHz`  | Frequency in GHz                 |
| `S11_Re` | Real part of S11                 |
| `S11_Im` | Imaginary part of S11            |
| `S21_Re` | Real part of S21                 |
| `S21_Im` | Imaginary part of S21            |

The simulation data are not included in this repository.

## Usage

1. Export the S-parameters from CST and save them with the column names above.
2. Place the file in the same folder as the script and set `filename` at the top of the script.
3. Run the script in MATLAB.

## Output

- A plot of the absorbance versus frequency.
- A results file with the columns `f_GHz` and `A_IMT` (update the file name here if you change it in the script).

## Notes and limitations

- For a metal-backed absorber, S21 is approximately zero, so the retrieved reflection coefficient reduces to S11 and the IMT absorbance equals 1 - |S11|^2. This script therefore checks the consistency of the S-parameter processing. It is not an independent solver.
- MATLAB's principal square root is used, which gives a non-negative real part for the impedance.
- The script does not run any electromagnetic simulation.

## Requirements

MATLAB (tested on release: R2020a, fill in). No additional toolboxes are needed.

## References

1. M. L. Hakim et al., "Polarization insensitive symmetrical structured double negative (DNG) metamaterial absorber for Ku-band sensing applications," Sci. Rep. 12, 479 (2022). https://doi.org/10.1038/s41598-021-04236-1
2. W. Zhu, "Electromagnetic Metamaterial Absorbers: From Narrowband to Broadband," in Metamaterials and Metasurfaces, IntechOpen (2018). https://doi.org/10.5772/intechopen.78581

## Citation

If you use this code, please cite the associated paper (will be updated after acceptance and publication):

T. Barua, A. A. Chy, A. K. M. A. R. Ferdous, S. Rahman, M. M. K. Shuvo, and M. S. Alam, "Numerical Investigation of a Quad-Resonant Metamaterial Absorber for Narrowband EMI Shielding in the X- and Ku-Bands," 7th International Conference on Electrical Engineering and
Information & Communication Technology (ICEEICT), Military Institute of Science & Technology (MIST), Bangladesh.

## License

Released under the MIT License. See the `LICENSE` file.

## Data availability

The simulation data are available from the corresponding author on reasonable request.
