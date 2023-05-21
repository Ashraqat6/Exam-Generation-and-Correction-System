using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace sql_project
{
    public partial class Exam_student : Form
    {
        ExamSYSEntities ent = new ExamSYSEntities();
        int? exId;
        List<exam_Questions_choices_Result> exQuestions = new List<exam_Questions_choices_Result>();
        int questionIndex;
        List<RadioButton> radios = new List<RadioButton>();
        int radioIndex = 0;
        int QuestionNum = 1;
        List<Stu_Answer> std_answers= new List<Stu_Answer>();
        public Exam_student()
        {
            InitializeComponent();
            radios.Add(radioButton1);
            radios.Add(radioButton2);
            radios.Add(radioButton3);
            radios.Add(radioButton4);

        }

        private void Exam_student_Load(object sender, EventArgs e)
        {
            Course crs = new Course();
            crs = (from c in ent.Courses where c.Crs_Name == student_courses.crs_name select c).FirstOrDefault();
            exId = ent.ShowExam(crs.Crs_Id).FirstOrDefault();
            exQuestions = ent.exam_Questions_choices(exId).ToList();
            questionIndex = 0;
            label2.Text = QuestionNum.ToString();
            foreach (var q in exQuestions)
            {
                bool included = false;
                foreach(Stu_Answer ans in std_answers)
                {
                    if (ans.Q_Id == q.Q_Id)
                    {
                        included= true;
                    }
                }
                if (included == false) 
                {
                    Stu_Answer answer = new Stu_Answer();
                    answer.Ex_Id = (int)exId;
                    answer.Q_Id = q.Q_Id;
                    answer.St_Id = Form1.id;
                    std_answers.Add(answer);
                }
            }
            ChangeQuestion();
            radioButton1.Checked = false;
            radioButton2.Checked = false;
            radioButton3.Checked = false;
            radioButton4.Checked = false;
        }
        private void button1_Click(object sender, EventArgs e)
        {
            if (QuestionNum != 10)
            {
                button1.Enabled = true;
                QuestionNum++;
                label2.Text = QuestionNum.ToString();
                questionIndex++;
                HideQuestionInfo();
                ChangeQuestion();
            }
            else
            {
                button1.Enabled = false;
                button2.Enabled = true;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (questionIndex > 0)
            {
                radioIndex = 0;
                questionIndex--;
                for (int i = 0; ; i++)
                {
                    if (exQuestions[questionIndex - i].Q_Id != exQuestions[questionIndex].Q_Id)
                    {

                        questionIndex -= i - 1;
                        break;
                    }
                }
                questionIndex--;
                int counter = 0;
                while (true)
                {
                    if (questionIndex - counter >= 0)
                    {
                        if (exQuestions[questionIndex - counter].Q_Id != exQuestions[questionIndex].Q_Id)
                        {

                            questionIndex -= counter - 1;
                            break;
                        }
                        counter++;
                    }
                    else
                    {
                        questionIndex = 0;
                        break;
                    }
                }
            };
            HideQuestionInfo();
            ChangeQuestion();

        }
        public void ChangeQuestion()
        {
            radioIndex = 0;
            label1.Text = exQuestions[questionIndex].Q_Title;
            label1.Visible = true;
            for (int i = 0; (questionIndex + i) <= exQuestions.Count - 1; i++)
            {
                if (exQuestions[questionIndex + i].Q_Id == exQuestions[questionIndex].Q_Id)
                {

                    radios[radioIndex].Text = exQuestions[questionIndex + i].choice;
                    radios[radioIndex].Visible = true;
                    radioIndex++;
                }
                else
                {
                    questionIndex += i - 1;
                    break;
                }

            }
            foreach(var ans in std_answers)
            {
                if (ans.Q_Id == exQuestions[questionIndex].Q_Id) 
                {
                    bool flag = false;
                    foreach(RadioButton radio in radios)
                    {
                        if (radio.Text == ans.St_Answer)
                        {
                            radio.Checked = true;
                            flag = true;
                        }
                    }
                    if (flag == false)
                    {
                        radioButton1.Checked = false;
                        radioButton2.Checked = false;
                        radioButton3.Checked = false;
                        radioButton4.Checked = false;
                    }
                }

            }


        }
        public void HideQuestionInfo()
        {
            label1.Visible = false;
            radioButton1.Visible = false;
            radioButton2.Visible = false;
            radioButton3.Visible = false;
            radioButton4.Visible = false;
        }
        public void checkQuestion(string answer)
        {
            foreach (Stu_Answer ans in std_answers)
            {
                if (ans.Q_Id == exQuestions[questionIndex].Q_Id)
                {
                    ans.St_Answer=answer;
                }

            }
        }
        private void radioButton1_Click(object sender, EventArgs e)
        {
            checkQuestion(radioButton1.Text);
        }

        private void radioButton2_Click(object sender, EventArgs e)
        {
            checkQuestion(radioButton2.Text);
        }

        private void radioButton3_Click(object sender, EventArgs e)
        {
            checkQuestion(radioButton3.Text);
        }

        private void radioButton4_Click(object sender, EventArgs e)
        {
            checkQuestion(radioButton4.Text);
        }
    }
}