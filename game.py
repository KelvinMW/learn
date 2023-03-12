import pygame

# Initialize Pygame
pygame.init()

# Set the size of the window
win_width = 800
win_height = 600
win = pygame.display.set_mode((win_width, win_height))

# Set the title of the window
pygame.display.set_caption("My 2D Game")

# Set the player's starting position
player_x = 50
player_y = 500

# Set the player's velocity
player_vel = 5

# Set the player's jump velocity
player_jump_vel = 10
player_jump_acc = 0.5
player_is_jumping = False

# Main game loop
run = True
while run:
    # Check for events
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            run = False
    
    # Get the keys that are currently pressed
    keys = pygame.key.get_pressed()
    
    # Move the player left
    if keys[pygame.K_LEFT]:
        player_x -= player_vel
    
    # Move the player right
    if keys[pygame.K_RIGHT]:
        player_x += player_vel
    
    # Make the player jump
    if keys[pygame.K_SPACE] and not player_is_jumping:
        player_is_jumping = True
        player_jump_vel = -10
    
    # Update the player's position if jumping
    if player_is_jumping:
        player_y += player_jump_vel
        player_jump_vel += player_jump_acc
        if player_y >= 500:
            player_is_jumping = False
            player_y = 500
    
    # Fill the window with white
    win.fill((255, 255, 255))
    
    # Draw the player
    pygame.draw.rect(win, (0, 0, 255), (player_x, player_y, 50, 50))
    
    # Update the display
    pygame.display.update()

# Quit Pygame
pygame.quit()


