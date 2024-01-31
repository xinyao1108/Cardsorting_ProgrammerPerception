
public class Card{

    private final String name;
    private final String description;
//    private final String category;

    private String stackName;
    private long startTime;
    private long endTime;
    private String sortPath;
    private boolean startTimeSet;

    public Card(final String name, final String description) {

        this.name = name;
        this.description = description;
//        this.category = category;

        this.stackName = "";
        this.endTime = 0;
        this.startTime = 0;
        this.startTimeSet = false;
        this.sortPath = "";
    }

    public void setStackName(String stackName){
        this.stackName = stackName;
    }

    public void setStartTime(long time){
        if(!this.startTimeSet){
            this.startTime = time;
            this.startTimeSet = true;
        }
    }

    public void setEndTime(long time){
        this.endTime = time;
    }

    public void setIsStartTime(boolean startTimeSet){
        this.startTimeSet = startTimeSet;
    }

    public void setSortPath(String path){
        this.sortPath = path;
    }

    public long getStartTime(){
        return this.startTime;
    }

    public long getEndTime(){
        return this.endTime;
    }

    public String getSortPath(){
        return sortPath;
    }

    public String getStackName(){
        return stackName;
    }

    public String getName(){
        return name;
    }

    public String getDescription(){
        return description;
    }

//    public String getCategory(){
//        return category;
//    }

}