class MeasurementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_measurement, only: [:show, :edit, :update, :destroy]

  # GET /measurements
  # GET /measurements.json
  def index
    @measurements = Measurement.all
  end

  # GET /measurements/1
  # GET /measurements/1.json
  def show

  end

  # GET /measurements/new
  # http://localhost:3000/measurements/new?temperature=27.4&humidity=14&lightLevel=33&device_id=2
  def new
    if measurement_params_no_require.any?
      @measurement = Measurement.new(measurement_params_no_require)

      respond_to do |format|
        if @measurement.save
          format.html { redirect_to @measurement, notice: 'Measurement was successfully created.' }
          format.json { render :show, status: :created, location: @measurement }
        else
          format.html { render :new }
          format.json { render json: @measurement.errors, status: :unprocessable_entity }
        end
      end
    else
      @measurement = Measurement.new
    end
  end

  # GET /measurements/1/edit
  def edit
  end

  # POST /measurements
  # POST /measurements.json
  def create
    @measurement = Measurement.new(measurement_params)

    respond_to do |format|
      if @measurement.save
        format.html { redirect_to @measurement, notice: 'Measurement was successfully created.' }
        format.json { render :show, status: :created, location: @measurement }
      else
        format.html { render :new }
        format.json { render json: @measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /measurements/1
  # PATCH/PUT /measurements/1.json
  def update
    respond_to do |format|
      if @measurement.update(measurement_params)
        format.html { redirect_to @measurement, notice: 'Measurement was successfully updated.' }
        format.json { render :show, status: :ok, location: @measurement }
      else
        format.html { render :edit }
        format.json { render json: @measurement.errors, status: :unprocessable_entity }
      end
    end
  end


  def showMeasurements
    dataFromMeasurements = Measurement.select("temperature, humidity, Lightlevel, created_at")
    temperature = []
    humidity = []
    lightLevel = []
    created_at = []

    dataFromMeasurements.each do |row|
      temperature.push(row.temperature)
      humidity.push(row.humidity)
      lightLevel.push(row.Lightlevel)
      created_at.push(row.created_at)
    end


    @test = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Temperature by time")
      f.xAxis(data: created_at)
      f.series(data: temperature)

      f.yAxis [
        {title: {text: "Temperature", margin: 70} },
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "line"})
    end


    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(categories: ["United States", "Japan", "China", "Germany", "France"])
      f.series(name: "GDP in Billions", yAxis: 0, data: [14119, 5068, 4985, 3339, 2656])
      f.series(name: "Population in Millions", yAxis: 1, data: [310, 127, 1340, 81, 65])

      f.yAxis [
        {title: {text: "GDP in Billions", margin: 70} },
        {title: {text: "Population in Millions"}, opposite: true},
      ]

      f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
      f.chart({defaultSeriesType: "column"})
    end

    @chart_globals = LazyHighCharts::HighChartGlobals.new do |f|
      f.global(useUTC: false)
      f.chart(
      backgroundColor: {
        linearGradient: [0, 0, 500, 500],
        stops: [
          [0, "rgb(255, 255, 255)"],
          [1, "rgb(240, 240, 255)"]
        ]
      },
      borderWidth: 2,
      plotBackgroundColor: "rgba(255, 255, 255, .9)",
      plotShadow: true,
      plotBorderWidth: 1
      )
      f.lang(thousandsSep: ",")
      f.colors(["#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"])
    end



  end

  # DELETE /measurements/1
  # DELETE /measurements/1.json
  def destroy
    @measurement.destroy
    respond_to do |format|
      format.html { redirect_to measurements_url, notice: 'Measurement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_measurement
    @measurement = Measurement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def measurement_params
    params.require(:measurement).permit(:temperature, :humidity, :lightLevel, :device_id)
  end
  # sem require
  def measurement_params_no_require
    params.permit(:temperature, :humidity, :lightLevel, :device_id)
  end
end
