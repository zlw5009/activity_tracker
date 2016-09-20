require 'pg'

class Database
  def initialize
    @db = PG.connect(dbname: "activity_tracker")
  end

  def query(statement, *params)
    @db.exec_params(statement, params)
  end

  def create_new_subject(subject_name)
    sql = "INSERT INTO subjects (name) VALUES ($1);"

    query(sql, subject_name)
  end

  def all_subjects
    sql = "SELECT * FROM subjects;"
    result = query(sql)

    result.map { |tuple| tuple_subject_to_hash(tuple) }
  end

  def subject_info(subject_id)
    sql = "SELECT * FROM subjects WHERE id = $1;"
    result = query(sql, subject_id)

    result.map { |tuple| tuple_subject_to_hash(tuple) }    
  end

  def all_topics(subject_id)
    sql = <<~SQL
      SELECT topics.*, subjects.name AS subject_name 
      FROM topics 
      RIGHT JOIN subjects ON subject_id = subjects.id 
      WHERE subject_id = $1;
    SQL

    result = query(sql, subject_id)

    result.map { |tuple| tuple_topic_to_hash(tuple) }
  end

  def create_new_topic(topic_name, subject_id)
    sql = "INSERT INTO topics (name, subject_id) VALUES ($1, $2);"

    query(sql, topic_name, subject_id)
  end

  def delete_topic(topic_id)
    sql = "DELETE FROM topics WHERE id = $1;"

    query(sql, topic_id)
  end

  def subject_name(subject_id)
    sql = "SELECT name FROM subjects WHERE id = $1"

    result = query(sql, subject_id)

    result.map { |tuple| tuple_subject_name_to_hash(tuple) }
  end

  private 

  def tuple_subject_to_hash(tuple)
    { id: tuple["id"].to_i,
      name: tuple["name"],
      duration: tuple["duration"] }
  end

  def tuple_topic_to_hash(tuple)
    { id: tuple["id"].to_i,
      name: tuple["name"],
      time_elapsed: tuple["time_elapsed"],
      subject_name: tuple["subject_name"] }
  end

  def tuple_subject_name_to_hash(tuple)
    { subject_name: tuple["name"] }
  end
end