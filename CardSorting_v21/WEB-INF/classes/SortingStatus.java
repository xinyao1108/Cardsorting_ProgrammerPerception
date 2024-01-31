import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "SortingStatus", urlPatterns = {"/SortingStatus"})
public class SortingStatus extends HttpServlet {

    Logger logger = Logger.getLogger(this.getClass().getName());
    
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
				
                HttpSession session = request.getSession(true);
                
                logger.log(Level.INFO, "Testing SortingStatus.");
                try{
                    int sis = (int) session.getAttribute("SIS");
                    String status = request.getParameter("SortingStatus");
                    String type = request.getParameter("SortingType");
                    //Logger logger = Logger.getLogger(this.getClass().getName());
                    //logger.log(Level.INFO, status);
                    //logger.log(Level.INFO, type);
                    logger.log(Level.INFO, String.valueOf(sis));
                    logger.log(Level.INFO, status);
                    logger.log(Level.INFO, type);

                    int CardSortingStatus = -1;
                    if(type.equals("Comfort")){
                        CardSortingStatus = (int) session.getAttribute("CardSortingStatus");
                    }

                    if (sis == 1 && status.equals("Done") && CardSortingStatus == 1){
                        //validate attention check
                        boolean passAC = validateAC(session, CardSortingStatus);
                        session.setAttribute("CardSortingStatus", 2);
                        if(!passAC){
                            saveProlificID(session,"Cards",1);
                            session.setAttribute("ValidationFail",1);
                        }
                        response.sendRedirect("ComfortReason.jsp");
                        
                    }else if(sis == 1 && status.equals("Done") && CardSortingStatus == 2){
                        response.sendRedirect("ComfortReason.jsp");
                    }else{
                        response.setContentType("text/plain");
                        PrintWriter writer = response.getWriter();
                        writer.println("Invalid Request");
                        writer.close();
                    }

                }catch(Exception e){
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    e.printStackTrace(writer);
                    writer.close();
                }
    }

    private void saveProlificID(HttpSession session,String CardsType, int CardSortingStatus) throws ServletException, IOException{
        String prolificID = (String) session.getAttribute("prolificID");
        String filename_usedIDs = this.getServletContext().getRealPath("Output/UsedIDs.csv");

        FileWriter usedIDs = new FileWriter(filename_usedIDs,true);
        String stackName = getStackNameAC(session,CardsType,CardSortingStatus);

        String output = prolificID+",Failed,"+stackName;

        usedIDs.write(output+"\n");
        usedIDs.close();
    }

    @SuppressWarnings("unchecked")
	private boolean validateAC(HttpSession session, int CardSortingStatus){
        String cardSet = "";
        String stackName = "";
        if(CardSortingStatus == 1){
            cardSet = "Cards";
            stackName = "Sensitive";
        }
        Logger logger = Logger.getLogger(this.getClass().getName());

        ArrayList<Card> cards = (ArrayList<Card>) session.getAttribute(cardSet);
        for(int i=0; i < cards.size(); i++){
            Card card = cards.get(i);

            String sortedStackName = card.getStackName();
            
            logger.log(Level.INFO, card.getName());
            if(card.getName().equals("Attention Check") && sortedStackName.equals(stackName)){
                logger.log(Level.INFO, sortedStackName);
                logger.log(Level.INFO, stackName);
                return true;
            }
        }

        return false;
    }

    @SuppressWarnings("unchecked")
	private String getStackNameAC(HttpSession session, String CardsType, int CardSortingStatus){
        ArrayList<Card> features = (ArrayList<Card>) session.getAttribute(CardsType);
        for(int i=0; i < features.size(); i++){
            Card card = features.get(i);
            if(card.getName().equals("Attention Check")){
                if(CardSortingStatus == 1){
                    return card.getStackName();
                }
            }
        }

        return "";
    }
	
}