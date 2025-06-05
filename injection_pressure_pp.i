####### INJECTION PRESSURE POSTPROCESSORS
# created by write_diracs_input.py
[Postprocessors]
  [p_in_1]
    type = PointValue
    variable = Pdiff
    point = '4.134516589 220.1299407155 396.4301458718'
  []

  [relative_pressure_16a]
    type = FunctionValuePostprocessor
    function = 'relative_pressure_16a'
  []

  [L2diff]
    type = ParsedPostprocessor
    expression = 'relative_pressure_16a-p_in_1'
    pp_names = 'relative_pressure_16a p_in_1'
  []

  [L2_integrated]
    type = TimeIntegratedPostprocessor
    value = L2diff
  []

  [log_inverse_error]
    type = FunctionValuePostprocessor
    function = 'log_inv_error'
  []  

  # [
[]

[Functions]
  [log_inv_error]
    type = ParsedFunction
    expression = 'log(1/((a)^2))'
    symbol_names = 'a'
    symbol_values = 'L2diff'
  []

  [relative_pressure_16a]
    type = PiecewiseLinear
    data_file = relative_pressure_well_16A.csv
    format ="columns"
  []

[]


