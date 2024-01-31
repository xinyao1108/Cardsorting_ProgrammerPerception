import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.FileWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

@SuppressWarnings("serial")
@WebServlet(name = "SubmitSurvey", urlPatterns = {"/SubmitSurvey"})
public class SubmitSurvey extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
    			try {
	                HttpSession session = request.getSession(true);
	                int sis = (int) session.getAttribute("SIS");
	                int cardSortingReason = (int) session.getAttribute("CardSortingReason");
	
	                if (sis == 1 && cardSortingReason == 1){
	                	int radioBtnPage = -1;
	                	radioBtnPage = (int) session.getAttribute("radioBtnPage");
	                	
	                	String[] variableList = new String[] {"profile","sender","locs","driver","known_face_encodings","PAYMENT_TOKEN","face_locations","institution","gdf_mask","username","address","password","yr_mt_dy","m3u8_url","name","gmap3","email","input_ips","tax","new_empID","api_key","transaction_id","online_bank_statement_provider","skill","pings","employees","session_cookie_value","his","paypal_mapping_id","face","age","MP4ASampleEntryBox","stream","addr","session_cookie_structure","long","browserhistory","latitude","m_d_y","addrinfo"};
                        String radioBtnAnswers = (String) session.getAttribute("radioBtnAnswers");
                        if (radioBtnPage > 0) {
                        	for (int i=(radioBtnPage-1)*20; i<(radioBtnPage*20); i++) {
                            	radioBtnAnswers += request.getParameter(variableList[i]) + ",";
                            }
                            session.setAttribute("radioBtnAnswers",radioBtnAnswers);
                        }
                        
	                   //write everything to file
	                   saveCradSorts(session);
	                   saveVariableCategory(session);
	                   // saveReason(session);
	                   // savePostSorting(session);
	                   saveProlificID(session);
	                   response.sendRedirect("ThankYou.html");
	                   session.invalidate();
	                }
    			}
    			catch(Exception e) {
					Logger logger = Logger.getLogger(this.getClass().getName());
                    logger.log(Level.WARNING, e.getMessage());
				}
            }

    @SuppressWarnings("unchecked")
	private void saveCradSorts(HttpSession session) throws ServletException, IOException{

        ArrayList<Card> datatypes = (ArrayList<Card>) session.getAttribute("Cards");
        String prolificID = (String) session.getAttribute("prolificID");

        for(int i = 0; i < datatypes.size(); i++ ){
            Card card = datatypes.get(i);
            String cardName = card.getName().replaceAll("[^a-zA-Z0-9]","");
            String filename = this.getServletContext().getRealPath("Output/Datatype/"+ cardName +".csv");
            FileWriter importance = new FileWriter(filename,true);

            long timeTaken = card.getEndTime() - card.getStartTime();

            importance.write(prolificID+","+card.getName()+","+card.getStackName()+"," + timeTaken +",\""+card.getSortPath()+"\"\n");
            importance.close();
        }
    }
    
    private void saveVariableCategory(HttpSession session) throws ServletException, IOException{
        // FILE HEADER 
    	// "email","profile","sender","locs","driver","known_face_encodings","PAYMENT_TOKEN","face_locations","institution","gdf_mask","username","address","password","yr_mt_dy","m3u8_url","name","gmap3","email","input_ips","tax","new_empID","api_key","transaction_id","online_bank_statement_provider","skill","pings","employees","session_cookie_value","his","paypal_mapping_id","face","age","MP4ASampleEntryBox","stream","addr","session_cookie_structure","long","browserhistory","latitude","m_d_y","addrinfo"
        
        String filename_variableCategory = this.getServletContext().getRealPath("Output/variableCategory.csv");
        FileWriter variableCategory = new FileWriter(filename_variableCategory,true);

        String prolificID = (String) session.getAttribute("prolificID");
        String output = prolificID + ",";
        output = output + session.getAttribute("radioBtnAnswers");
        variableCategory.write(output+"\n");
        variableCategory.close();
    }

    private void saveReason(HttpSession session) throws ServletException, IOException{
        String [] attributes = {"LessImportantReason", "MoreImportantReason"};
        
        String filename_reason = this.getServletContext().getRealPath("Output/reason.csv");
        FileWriter reason = new FileWriter(filename_reason,true);

        String prolificID = (String) session.getAttribute("prolificID");
        String output = prolificID;
        for (int i=0;  i < attributes.length; i++){
            output = output + ",\"" + ( (String) session.getAttribute(attributes[i]) )+"\"";
        }
        reason.write(output+"\n");
        reason.close();
    }

    private void savePostSorting(HttpSession session) throws ServletException, IOException{
        String [] attributes = {"age","gender","degree","yearsProgExp","progLangUsed","ConsiderTechSec","secVSFuncImporance","secVSSatisfactionImporance"};
        
        String filename_postSorting = this.getServletContext().getRealPath("Output/postSorting.csv");
        FileWriter postSorting = new FileWriter(filename_postSorting,true);

        String prolificID = (String) session.getAttribute("prolificID");
        String output = prolificID;
        for (int i=0;  i < attributes.length; i++){
            output = output + "," + ( (String) session.getAttribute(attributes[i]) );
        }
        postSorting.write(output+"\n");
        postSorting.close();
    }

    private void saveProlificID(HttpSession session) throws ServletException, IOException{
        String prolificID = (String) session.getAttribute("prolificID");
        String filename_usedIDs = this.getServletContext().getRealPath("Output/UsedIDs.csv");
        int validationFail = (int) session.getAttribute("ValidationFail");
        
        if (validationFail != 1){
            FileWriter usedIDs = new FileWriter(filename_usedIDs,true);

            String output = prolificID+",Completed";

            usedIDs.write(output+"\n");
            usedIDs.close();
        }
    }

}