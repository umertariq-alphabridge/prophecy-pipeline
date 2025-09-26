Schedule = Schedule(cron = "* 0 2 * * * *", timezone = "GMT", emails = ["email@gmail.com"], enabled = False)
SensorSchedule = SensorSchedule(enabled = False)

with DAG(Schedule = Schedule, SensorSchedule = SensorSchedule):
    aggpipeline__product_profit_summary_1 = Task(
        task_id = "aggpipeline__product_profit_summary_1", 
        component = "Model", 
        modelName = "aggpipeline__product_profit_summary_1"
    )
