require 'csv'
namespace :import_csv do

    desc "CSVデータをインポートするタスク"

    task users: :environment do
      path = "db/csv_data/csv_data.csv"

      list = []
      CSV.foreach(path, headers: true) do |row|
        list << row.to_h
      end
      puts "インポート処理を開始"
      begin
        User.transaction do
        User.create!(list)
        end
        puts "インポート完了!!".green
      rescue StandardError => e

        puts <<~TEXT
        "#{e.class}: #{e.message}".red
        "---------------------------------"
        e.backtrace
        "---------------------------------"
        "インポートに失敗".red
        TEXT
      end
    end
  end
