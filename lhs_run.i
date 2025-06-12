[StochasticTools]
[]

[Distributions]
  [matrix_poro]
    type = Uniform
    lower_bound = 1e-6 #10
    upper_bound = 1e-5#3000
  []
[]

[Samplers]
  [sample]
    type = LatinHypercube
    distributions = 'matrix_poro'
    num_rows = 2
    seed = 1980
    execute_on = 'PRE_MULTIAPP_SETUP'
    min_procs_per_row = 2
  []
[]

[MultiApps]
  [sub]
    type = SamplerFullSolveMultiApp
    input_files = 2dFrac_10zone.i
    sampler = sample
    ignore_solve_not_converge = true
    mode = batch-reset
    min_procs_per_app = 2
  []
[]

[VectorPostprocessors]
  [dfn_values_random]
    type = SamplerData
    sampler = sample
  []
[]

[Controls]
  [cmdLine]
    type = MultiAppSamplerControl
    multi_app = sub
    sampler = sample
    param_names = 'matrix_poro'
  []
[]

[Outputs]
  console = false
  csv = true
  execute_on = 'FINAL'
[]