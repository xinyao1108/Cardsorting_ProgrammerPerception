import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

@SuppressWarnings("serial")
@WebServlet(name = "Reason", urlPatterns = {"/Reason"})
public class Reason extends HttpServlet {

    String homPath = "";

    /* protected void doGet(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession(true);
    } */
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
                
                HttpSession session = request.getSession(true);
                try{
                    int sis = (int) session.getAttribute("SIS");
                    String type = request.getParameter("SortingType");

                    int comfortSorting = -1;
                    int radioBtnPage = -1;
                    if (type.equals("Comfort")){
                        comfortSorting = (int) session.getAttribute("CardSortingStatus");
                        radioBtnPage = (int) session.getAttribute("radioBtnPage");
                    }

                    if (sis == 1 && comfortSorting == 2){
                        // String lessImportantReason = request.getParameter("LessImportantReason");
                        // String moreImportantReason = request.getParameter("MoreImportantReason");
                        
                        session.setAttribute("CardSortingReason", 1);
                        // session.setAttribute("LessImportantReason",lessImportantReason);
                        // session.setAttribute("MoreImportantReason",moreImportantReason);
                        
                        String[] variableList = new String[] {"profile","sender","locs","driver","known_face_encodings","PAYMENT_TOKEN","face_locations","institution","gdf_mask","username","address","password","yr_mt_dy","m3u8_url","name","gmap3","email","input_ips","tax","new_empID","api_key","transaction_id","online_bank_statement_provider","skill","pings","employees","session_cookie_value","his","paypal_mapping_id","face","age","MP4ASampleEntryBox","stream","addr","session_cookie_structure","long","browserhistory","latitude","m_d_y","addrinfo"};
                        String radioBtnAnswers = (String) session.getAttribute("radioBtnAnswers");
                        if (radioBtnPage > 0) {
                        	for (int i=(radioBtnPage-1)*20; i<(radioBtnPage*20); i++) {
                            	radioBtnAnswers += request.getParameter(variableList[i]) + ",";
                            }
                            session.setAttribute("radioBtnAnswers",radioBtnAnswers);
                        }
                        response.sendRedirect("ComfortReason3.jsp");
                    }else{
                        response.setContentType("text/plain");
                        PrintWriter writer = response.getWriter();
                        writer.println("Invalid Request");
                        writer.close();
                    }

                }catch(Exception e){
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    e.printStackTrace(writer);
                    writer.close();
                }
    }
	
}