import java.io.IOException;
import java.io.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet(name = "PostID", urlPatterns = {"/PostID"})
public class PostID extends HttpServlet {

    protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
                
                HttpSession session = request.getSession(true);

                try{
                    //Get prolific ID number entered by the participant and evaluate if it has been used.
                    //Redirect the participant to the instructions page if the ID is valid. 
                	
                	int sis = (int) session.getAttribute("SIS");                	
                    ArrayList<String> usedIDs = getIDs("UsedIDs.csv");                    
                    String cardNum = request.getParameter("prolificID");
                    cardNum = cardNum.trim().toUpperCase();
                    boolean used = usedIDs.contains(cardNum);
                    
                    if (sis==1 && !used){
                        session.setAttribute("prolificID",cardNum);
                        session.setAttribute("ReceivedID",1);
                        response.sendRedirect("Instructions.jsp");
                    }else if (sis==1 && used){
                        response.sendRedirect("invalid.html");
                        session.invalidate();
                    }else{
                        response.sendRedirect("index.html");
                    }
                }catch(Exception e){
                	Logger logger = Logger.getLogger(this.getClass().getName());
                    logger.log(Level.WARNING, e.getMessage());
                    
                    response.setContentType("text/plain");
                    PrintWriter writer = response.getWriter();
                    writer.println("An error has occured posting the ID.");
                    response.sendRedirect("index.html");
                    e.printStackTrace(writer);
                    writer.close();
                }

    }

    @SuppressWarnings("resource")
	protected ArrayList<String> getIDs(String fileName) throws IOException{
    	String path =  this.getServletContext().getRealPath("Output/"+fileName);
		
		File file = new File(path);
		BufferedReader br = new BufferedReader(new FileReader(file));
        ArrayList<String> returnList = new ArrayList<String>();
        
        Logger logger = Logger.getLogger(this.getClass().getName());
		String id;
		while ((id = br.readLine()) != null){
			if (!id.isEmpty()) {
	            id = id.substring(0,id.indexOf(","));
	            returnList.add(id);
	            logger.log(Level.INFO, id);
			}
		}
		
		return returnList;
	}
}