
from flask import Flask, render_template, request
import psycopg2


app = Flask( __name__ )
conn = psycopg2.connect(database='Lab7', user='postgres', password='123', host="localhost", port="5432")
cursor = conn.cursor()

@app.route('/')
def index():
    return '''
    <h1>EasyDB</h1>
    <ul>
        <li><a href="/DisplayAll">Display All</a></li>
        <li><a href="/search">Search</a></li>
        <li><a href="/insert">Insert Data</a></li>
        <li><a href="/delete_student">Delete Student</a></li>
        <li><a href="/delete_teacher_without_courses">Delete Teacher Without Courses</a></li>
    </ul>
    '''

@app.route('/DisplayAll')
def DisplayAll():
    SQL_students = 'SELECT * from students'
    cursor.execute(SQL_students)
    students = cursor.fetchall()

    SQL_courses = 'SELECT * from courses'
    cursor.execute(SQL_courses)
    courses = cursor.fetchall()

    SQL_teachers = 'SELECT * from teachers'
    cursor.execute(SQL_teachers)
    teachers = cursor.fetchall()

    SQL_dependent = 'SELECT * from dependent'
    cursor.execute(SQL_dependent)
    dependent = cursor.fetchall()

    SQL_total = 'SELECT COUNT(*) from students'
    cursor.execute(SQL_total)
    total = cursor.fetchall()

    return render_template(
        'DisplayAll.html',
        students=students,
        courses=courses,
        teachers=teachers,
        dependent=dependent,
        total=total
    )

@app.route('/search', methods=['GET', 'POST'])
def search():
    student_data = None
    teacher_data = None
    dependent_data = None
    courses_taught = []
    dependents = []
    insured_price_sum = None
    course_data = None

    if request.method == 'POST':
        search_type = request.form.get('search_type')  # Identify the type of search

        with conn.cursor() as cur:
            if search_type == 'student':
                student_id = request.form.get('student_id')
                cur.execute("SELECT * FROM Students WHERE studentID = %s", (student_id,))
                student_data = cur.fetchone()

            elif search_type == 'teacher':
                teacher_id = request.form.get('teacher_id')
                cur.execute("SELECT teacherName FROM Teachers WHERE teacherID = %s", (teacher_id,))
                teacher_data = cur.fetchone()

                cur.execute("SELECT courseName FROM Courses WHERE teacherID = %s", (teacher_id,))
                courses_taught = cur.fetchall()

                cur.execute("SELECT dependentName, InsuredPrice, relation FROM Dependent WHERE teacherID = %s",(teacher_id,))
                dependents = cur.fetchall()

                cur.execute("SELECT SUM(InsuredPrice) FROM Dependent WHERE teacherID = %s",(teacher_id,))
                insured_price_sum = cur.fetchone()[0]


            
            elif search_type == 'dependent':
                dependent_name = request.form.get('dependent_name')
                cur.execute(
                    "SELECT Teachers.teacherName, Dependent.relation "
                    "FROM Dependent "
                    "JOIN Teachers ON Dependent.teacherID = Teachers.teacherID "
                    "WHERE Dependent.dependentName = %s",(dependent_name,))
                dependent_data = cur.fetchone()



            elif search_type == 'course':
                course_id = request.form.get('course_id')
                cur.execute(
                    "SELECT Courses.courseName, Teachers.teacherName "
                    "FROM Courses "
                    "JOIN Teachers ON Courses.teacherID = Teachers.teacherID "
                    "WHERE Courses.courseID = %s",(course_id,))
                course_data = cur.fetchone()

    return render_template(
        'Search.html',
        student_data=student_data,
        teacher_data=teacher_data,
        courses_taught=courses_taught,
        dependents=dependents,
        insured_price_sum=insured_price_sum,
        dependent_data=dependent_data,
        course_data=course_data
    )


@app.route('/insert', methods=['GET', 'POST'])
def insert_data():
    message = None

    if request.method == 'POST':
        table_name = request.form.get('table_name')

        try:
            with conn.cursor() as cur:
                if table_name == 'students':
                    student_id = request.form.get('student_id')
                    name = request.form.get('name')
                    dob = request.form.get('dob')

                    if not student_id or not name or not dob:
                        message = "All fields are required for inserting a student!"
                    else:
                        cur.execute(
                            "INSERT INTO Students (studentID, studentname, dob) VALUES (%s, %s, %s)",
                            (student_id, name, dob),
                        )
                        message = "Student inserted successfully!"

                elif table_name == 'courses':
                    course_id = request.form.get('course_id')
                    course_name = request.form.get('course_name')
                    teacher_id = request.form.get('teacher_id')
                    time = request.form.get('time')
                    description = request.form.get('description') or None

                    if not course_id or not course_name or not teacher_id or not time:
                        message = "Course ID, Course Name, Teacher ID and Time are required!"
                    else:
                        cur.execute(
                            "INSERT INTO Courses (courseID, courseName, description, teacherID, time) VALUES (%s, %s, %s, %s ,%s)",
                            (course_id, course_name,description, teacher_id, time),
                        )
                        message = "Course inserted successfully!"

                elif table_name == 'teachers':
                    teacher_id = request.form.get('teacher_id')
                    teacher_name = request.form.get('teacher_name')

                    if not teacher_id or not teacher_name:
                        message = "All fields are required for inserting a teacher!"
                    else:
                        cur.execute(
                            "INSERT INTO Teachers (teacherID, teacherName) VALUES (%s, %s)",
                            (teacher_id, teacher_name),
                        )
                        message = "Teacher inserted"

                elif table_name == 'dependent':
                    dependent_name = request.form.get('dependent_name')
                    teacher_id = request.form.get('teacher_id')
                    insured_price = request.form.get('insured_price')
                    relation = request.form.get('relation')

                    if not dependent_name or not teacher_id or not insured_price or not relation:
                        message = "All fields are required for inserting a dependent!"
                    else:
                        cur.execute(
                            "INSERT INTO Dependent (dependentName, teacherID, InsuredPrice, relation) VALUES (%s, %s, %s, %s)",
                            (dependent_name, teacher_id, insured_price, relation),
                        )
                        message = "Dependent inserted successfully!"


                elif table_name == "take":
                    student_id = request.form.get('student_id')
                    course_id = request.form.get('course_id')
                    if not student_id or not course_id:
                        message = "All fields are required for inserting a dependent!"
                    else:
                        cur.execute(
                            "INSERT INTO Take (studentID, courseID) VALUES (%s, %s)",
                            (student_id, course_id),
                        )
                        message = "Dependent inserted successfully!"

                elif table_name == 'StudentInformation':
                    student_id = request.form.get('student_id')
                    info = request.form.get('info')
                    if not student_id or not info:
                        message = "All fields are required for inserting a student information!"
                    else:
                        cur.execute(
                            "INSERT INTO StudentInformation (studentID, inform) VALUES (%s, %s)",
                            (student_id, info),
                        )
                        message = "Student information inserted successfully!"
                conn.commit()

        except Exception as e:
            conn.rollback()
            message = f"An error occurred: {str(e)}"

    return render_template('InsertData.html', message=message)




@app.route('/delete_student', methods=['GET', 'POST'])
def delete_student():
    message = None

    if request.method == 'POST':
        action = request.form.get('action')
        
        if action == 'delete_course_student':
            student_id = request.form.get('student_id')

            if not student_id:
                message = "Student ID is required for deleting a student!"
            else:
                try:
                    with conn.cursor() as cur:
                        cur.execute("SELECT courseID FROM Take WHERE studentID = %s", (student_id,))
                        course_id = cur.fetchone()

                        if course_id:
                            course_id = course_id[0]  

                            cur.execute("SELECT COUNT(*) FROM Take WHERE courseID = %s", (course_id,))
                            student_count = cur.fetchone()[0]

                            if student_count > 5:
                                cur.execute("DELETE FROM Take WHERE studentID = %s AND courseID = %s", (student_id, course_id))
                                cur.execute("DELETE FROM Students WHERE studentID = %s", (student_id,))
                                conn.commit()
                                message = "Student deleted successfully from Students and Take table!"
                            else:
                                message = f"Cannot delete: Course has only {student_count} students."

                except Exception as e:
                    conn.rollback()
                    message = f"An error occurred: {str(e)}"

        elif action == 'delete_non_enrolled':
            try:
                with conn.cursor() as cur:
                    cur.execute("DELETE FROM Students WHERE studentID NOT IN (SELECT studentID FROM Take)")
                    conn.commit()
                    message = "Students not enrolled in any course deleted successfully!"
            except Exception as e:
                conn.rollback()
                message = f"An error occurred: {str(e)}"

    return render_template('DeleteStudent.html', message=message)



@app.route('/delete_teacher_without_courses', methods=['GET', 'POST'])
def delete_teacher_without_courses():
    message = None

    if request.method == 'POST':
        try:
            with conn.cursor() as cur:
                cur.execute("""
                    SELECT t.teacherID
                    FROM Teachers t
                    LEFT JOIN Courses c ON t.teacherID = c.teacherID
                    WHERE c.teacherID IS NULL
                """)
                teachers_to_delete = cur.fetchall()

                if not teachers_to_delete:
                    message = "No teachers found who are not teaching any course."
                else:
                    for teacher in teachers_to_delete:
                        teacher_id = teacher[0]
                        cur.execute("DELETE FROM Dependent WHERE teacherID = %s", (teacher_id,))

                        cur.execute("DELETE FROM Teachers WHERE teacherID = %s", (teacher_id,))

                    conn.commit()
                    message = "Teachers without courses and their dependent have been deleted successfully!"
        except Exception as e:
            conn.rollback()
            message = f"An error occurred: {str(e)}"

    return render_template('DeleteTeacher.html', message=message)

if __name__ == '__main__':
    app.run(debug=True)