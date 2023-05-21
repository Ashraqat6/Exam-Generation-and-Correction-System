using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace sql_project
{
    public partial class student_courses : Form
    {
        ExamSYSEntities ent = new ExamSYSEntities();
        public static string crs_name; 
        public student_courses()
        {
            InitializeComponent();
        }

        private void student_courses_Load(object sender, EventArgs e)
        {
            Student std = ent.Students.Find(Form1.id);
           
            foreach (var std_crs in std.Stud_Course)
            {
                var course = ent.Courses.Find(std_crs.Crs_Id);
                listBox1.Items.Add(course.Crs_Name);
            }
        }

        private void TakeExam_Click(object sender, EventArgs e)
        {
            
            if (listBox1.SelectedItem != null)
            {
                crs_name = listBox1.SelectedItem.ToString();
                //this.Hide();
                Exam_student std_exam = new Exam_student();
                std_exam.ShowDialog();
            }
            else
            {
                MessageBox.Show("choose course ");
            }
        }
    }
}
