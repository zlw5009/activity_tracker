require 'pg'

class Database
  def initialize
    @db = PG.connect(dbname: "activity_tracker")
  end

  def query(statement, *params)
    @db.exec_params(statement, params)
  end

  def create_new_subject(subject_name)
    sql = "INSERT INTO subjects (name) VALUES ($1)"

    query(sql, subject_name)
  end

  def all_subjects
    sql = "SELECT * FROM subjects;"

    result = query(sql)

    result.map { |tuple| tuple_to_hash(tuple) }
  end

  private 

  def tuple_to_hash(tuple)
    { id: tuple["id"].to_i,
      name: tuple["name"],
      duration: tuple["duration"] }
  end
end