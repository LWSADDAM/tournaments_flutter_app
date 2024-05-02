double mapRange(double value, double minInput, double maxInput,
    double minOutput, double maxOutput) {
  return minOutput +
      ((value - minInput) / (maxInput - minInput)) * (maxOutput - minOutput);
}
