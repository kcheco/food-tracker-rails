class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :update, :destroy]

  def index
    @meals = Meal.all
    render json: @meals
  end

  def create
    @meal = Meal.create!(meal_params)
    render json: @meal, status: :created
  end

  def show
    render json: @meal
  end

  def update
    @meal.update(meal_params)
    head :no_content
  end

  def destroy
    @meal.destroy
    head :no_content
  end

  private
  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.permit(:name, :photo, :rating)
  end
end
