import random

def is_player_starting()-> bool:
  userChoice: int = int(input("Orzeł (1)? Czy reszka(2)?: "))
  if userChoice==1 or userChoice==2:
    lottery: int = random.randint(1,2)
    
    if lottery==2 and userChoice==2:
      return True
    elif lottery == 1 and userChoice == 1:
      return True
    else:
      return False
    

def get_user_move(board: list) -> None:
  row: int = int(input("w którym rzędzie chcesz postawić znak? (1-5): "))
  column: int = int(input("w której kolumnie chcesz postawić znak? (1-5): "))
  if board[row-1][column-1]=="":
    board[row-1][column-1]=="X"
    print("git")
  else:
    print("zajete")

"""

board = [["X","X",""],
         ["","",""],
         ["","","X"]]


get_user_move(board)"""

def get_free(board: list) -> list:
  result = list()
  for row in range (0, len(board)):
    for column in range (0, len(board[row])):
      if board[row][column]=="":
        result.append((row, column))
        return result



def ai_move(board: list) -> None:
  potential_move = get_free(board)
  move = potential_move[random.randint(0,len(potential_move))]
  board[move[0],move[1]] = "O"