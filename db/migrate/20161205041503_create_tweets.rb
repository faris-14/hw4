class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.binary :avatar
      t.text :name
      t.text :content
      t.datetime :time

      t.timestamps
    end
  end
end
