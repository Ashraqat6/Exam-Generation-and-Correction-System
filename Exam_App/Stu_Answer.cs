//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace sql_project
{
    using System;
    using System.Collections.Generic;
    
    public partial class Stu_Answer
    {
        public int Ex_Id { get; set; }
        public int St_Id { get; set; }
        public int Q_Id { get; set; }
        public Nullable<System.DateTime> date { get; set; }
        public string St_Answer { get; set; }
    
        public virtual Exam Exam { get; set; }
        public virtual Question Question { get; set; }
        public virtual Student Student { get; set; }
    }
}
