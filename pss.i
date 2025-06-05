[StochasticTools]
[]

[Distributions]
  [fracture_aperture]
    type = Normal
    mean = 20e-5
    standard_deviation = 6e-5
  []
  [fracture_roughness]
    type = Normal
    mean = 12e-3
    standard_deviation = 2.5e-3
  []
[]

[Samplers]
  [sample]
    type = ParallelSubsetSimulation
    distributions = 'fracture_aperture fracture_roughness'
    num_samplessub = 200
    num_subsets = 5
    num_parallel_chains = 20
    output_reporter = 'constant/reporter_transfer:log_inverse_error:value'
    inputs_reporter = 'adaptive_MC/inputs'
    seed = 1012
    execute_on = PRE_MULTIAPP_SETUP
  []
[]

[MultiApps]
  [sub]
    type = SamplerFullSolveMultiApp
    input_files = 2dFrac_10zone2.i
    sampler = sample
  []
[]

[Transfers]
  [reporter_transfer]
    type = SamplerReporterTransfer
    from_reporter = 'log_inverse_error/value'
    stochastic_reporter = 'constant'
    from_multi_app = sub
    sampler = sample
  []
[]

[Controls]
  [cmdline]
    type = MultiAppSamplerControl
    multi_app = sub
    sampler = sample
    param_names = 'p1 p4'
  []
[]

[Reporters]
  [constant]
    type = StochasticReporter
    outputs = none
  []
  [adaptive_MC]
    type = AdaptiveMonteCarloDecision
    output_value = constant/reporter_transfer:log_inverse_error:value
    inputs = 'inputs'
    sampler = sample
  []
[]

[Executioner]
  type = Transient
[]

[Outputs]
  [out]
    type = JSON
    execute_system_information_on = none
  []
[]
