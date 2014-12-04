# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

City.create!(name: 'New York', lat: '40.757929', lon: '-73.985506')
City.create!(name: 'San Francisco', lat: '37.775196', lon: '-122.419204')
City.create!(name: 'Chicago', lat: '41.879535', lon: '-87.624333')

Phrase.create!(body: 'Pizza', author: 'admin')