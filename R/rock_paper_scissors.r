# defining function and set variables
rps_game <- function() {
    message("Welcome to Rock Paper Scissors Game!")
    score_player <- 0
    score_computer <- 0
    draw <- 0
    choices <- c("rock", "paper", "scissors")

    # while loop and get input from both player and computer
    while(TRUE) {
        message('Please choose "rock" or "paper" or "scissors" to take action or "quit" to leave the game.')
        p_ch <- tolower(readline("Choose your option: "))
        c_ch <- sample(choices, 1)
    
        ## check who wins
        score <- list(score_player, score_computer, draw)
        if (p_ch == c_ch) {
            message("Player: ",p_ch, " VS. Computer: ",c_ch)
            message("Draw Round!")
            draw <- draw + 1
        } else if (p_ch == "rock" & c_ch == "scissors") {
            message("Player: ",p_ch, " VS. Computer: ",c_ch)
            message("You Win The Round!")
            score_player <- score_player + 1
        } else if (p_ch == "rock" & c_ch == "paper") {
            message("Player: ",p_ch, " VS. Computer: ",c_ch)
            message("Computer Wins The Round!")
            score_computer <- score_computer + 1
        } else if (p_ch == "paper" & c_ch == "rock") {
            message("Player: ",p_ch, " VS. Computer: ",c_ch)
            message("You Win The Round!")
            score_player <- score_player + 1
        } else if (p_ch == "paper" & c_ch == "scissors") {
            message("Player: ",p_ch, " VS. Computer: ",c_ch)
            message("Computer Wins The Round!")
            score_computer <- score_computer + 1
        } else if (p_ch == "scissors" & c_ch == "paper") {
            message("Player: ",p_ch, " VS. Computer: ",c_ch)
            message("You Win The Round!")
            score_player <- score_player + 1
        } else if (p_ch == "scissors" & c_ch == "rock") {
            message("Player: ",p_ch, " VS. Computer: ",c_ch)
            message("Computer Wins The Round!")
            score_computer <- score_computer + 1
        } else if (p_ch == "quit") {
            message("Summary score: ", "Win = ", score_player, ", Draw = ", draw, ", Lose = ", score_computer)
            if (score_player > score_computer) {
                message("You Win! Congratulations!")
            } else if (score_player < score_computer) {
                message("Computer wins! Better luck next time!")
            } else {
                message("It's a draw game!")
            }
            message("Thank you for playing!")
            break
        } else {
            message("Invalid input! Choose again!")
        }
    }
}
