using System.Collections.Generic;
using System.Linq;
using CSETWebCore.Interfaces.AdminTab;
using CSETWebCore.Model.AdminTab;
using CSETWebCore.DataLayer.Model;

namespace CSETWebCore.Business.AdminTab
{
    /// <summary>
    /// A class that deals with ACET functionality.
    /// </summary>
    public class AdminTabBusiness : IAdminTabBusiness
    {
        private CSETContext _context;


        /// <summary>
        /// Constructs a new instance of AdminTabBusiness
        /// </summary>
        /// <param name="context"></param>
        public AdminTabBusiness(CSETContext context)
        {
            _context = context;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="assessmentId"></param>
        /// <returns></returns>
        public AdminTabData GetTabData(int assessmentId)
        {
            Dictionary<string, int> countStatementsReviewed = new Dictionary<string, int>();

            AdminTabData rvalue = new AdminTabData();

            try
            {
                var stmtCounts = _context.usp_StatementsReviewed(assessmentId).ToList<usp_StatementsReviewed_Result>();
                foreach (var row in stmtCounts)
                {
                    rvalue.DetailData.Add(new FINANCIAL_HOURS_OVERRIDE(row));
                    countStatementsReviewed[row.Component] = row.ReviewedCount ?? 0;
                }

                var totals = _context.usp_StatementsReviewedTabTotals(assessmentId).ToList<usp_StatementsReviewedTabTotals_Result>();
                foreach (var row in totals)
                {
                    rvalue.ReviewTotals.Add(new ReviewTotals() { Total = row.Totals, ReviewType = row.ReviewType });
                    rvalue.GrandTotal = row.GrandTotal ?? 0;
                }
            }
            catch (System.Exception exc)
            {
                log4net.LogManager.GetLogger(this.GetType()).Error($"... {exc}");
            }

            // add another total entry for Statements Reviewed   

            var totalReviewed = new ReviewTotals
            {
                ReviewType = "Statements Reviewed",
                Total = 0
            };
            foreach (var d in countStatementsReviewed)
            {
                totalReviewed.Total += d.Value;
            }
            rvalue.ReviewTotals.Add(totalReviewed);


            rvalue.Attributes = _context.usp_financial_attributes(assessmentId).ToList();
            return rvalue;
        }
       

        /// <summary>
        /// 
        /// </summary>
        /// <param name="assessmentId"></param>
        /// <param name="att"></param>
        public void SaveDataAttribute(int assessmentId, AttributePair att)
        {
            var item = _context.FINANCIAL_ASSESSMENT_VALUES.Where(x => x.Assessment_Id == assessmentId && x.AttributeName == att.AttributeName).FirstOrDefault();
            if (item == null)
            {
                _context.FINANCIAL_ASSESSMENT_VALUES.Add(new FINANCIAL_ASSESSMENT_VALUES()
                {
                    Assessment_Id = assessmentId,
                    AttributeName = att.AttributeName,
                    AttributeValue = att.AttributeValue
                });
                _context.SaveChanges();
            }
            else
            {
                item.AttributeValue = att.AttributeValue;
                _context.SaveChanges();
            }
        }
    }
}