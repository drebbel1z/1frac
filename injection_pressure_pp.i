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
    expression = 'if(t<=3.5*24*3600,(relative_pressure_16a-p_in_1)^2,0)'
    pp_names = 'relative_pressure_16a p_in_1'
    use_t= true
  []

  [L2_integrated]
    type = TimeIntegratedPostprocessor
    value = L2diff
  []

  # [mass_rate]
  #   type = FunctionValuePostprocessor
  #   function = 'mass_rate'
  # []

  [mass_rate_simulation]
    type = ParsedPostprocessor
    expression = '(fluid_report/a1_dt/2.65 - 0.25*8)^2'
    pp_names = 'fluid_report a1_dt'
  []

  [log_inverse_error]
    type = FunctionValuePostprocessor
    function = 'log_inv_error'
  []  
[]

[Functions]
  [log_inv_error]
    type = ParsedFunction
    expression = '-a/1e18 - b/30.0'
    symbol_names = 'a b'
    symbol_values = 'L2_integrated mass_rate_simulation'
  []

  [relative_pressure_16a]
    type = PiecewiseLinear
    data_file = relative_pressure_well_16A.csv
    format ="columns"
  []

  # [mass_rate]
  #   type = PiecewiseLinear
  #   data_file = mass_rate.csv
  #   format ="columns"
  # []
[]


