using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace sql_project
{
    public partial class Form1 : Form
    {
       ExamSYSEntities ent = new ExamSYSEntities();
        public static int id;
        public static string name;
        public static string user;

        public Form1()
        {
            InitializeComponent();

        
        }

        private void login_btn_Click(object sender, EventArgs e)
        {
           if(textBox1.Text !=null && textBox2.Text!=null && comboBox1.Text!= null)
            {
                id =int.Parse(textBox2.Text);
                name=textBox1.Text;
                if (user == "Student")
                {
                    var student = ent.Students.Find(id);
                    if (student != null && student.St_Fname.ToLower() == name.ToLower())
                    {
                        MessageBox.Show($"Hi {name}");
                        //this.Hide();
                        student_courses std_crs = new student_courses();
                        std_crs.ShowDialog();

                    }
                    else
                    {
                        MessageBox.Show("Wrong Data");
                    }
                }
                else
                {
                    MessageBox.Show(" instructor ");
                }
            }
            else
            {
                MessageBox.Show("Please enter valid data");
            }


        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            user = comboBox1.Text;
        }
    }
}
