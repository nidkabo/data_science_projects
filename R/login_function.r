# username password login application
## login function that a user can try 3 times of attempts to login

## import library
library(glue)

login_fn <- function() {
    
    username <- "myusername01"
    password <- "12345678"
    count <- 3
    
    while(count > 0) {
        un_input <- readline("Username: ")
        pw_input <- readline("Password: ")
        
        ## check username and password
        if (username == un_input & password == pw_input) {
            print("You have successfully logged in.")
            break
        } else {
            count <- count - 1
            if (count > 0) {
                print(glue("Incorrect username or password. You have {count} more attempt(s) to log in."))
            } else {
                print("Sorry, you've tried to log in too many times with an incorrect username or password. Please contact admin.")
            }
        }
    }
}
