clc, clear

game = struct(); % Game is the highest-level parent in the structure

game.ver = 'v1.2.0b'; % Version information that will be stored as a child of game. v1.0.0a means alpha version of version 1.0.0 --- Now it Beta. Tested heavily by numerous people.

game.player = struct();
game.player.name = "";
game.player.data = struct();
game.player.data.name = "";
game.player.inventory = struct();
game.player.data.fields = struct();
game.player.data.fieldCount = 0;
game.player.data.cash = 500;
game.player.data.reputation = 50;

game.aliases = struct();
game.aliases.yes = ["Y", "Yes"];
game.aliases.no = ["N", "No"];
game.aliases.load = ["L", "Load", "Load Game", "1"];
game.aliases.newGame = ["N", "New", "New Game", "2"];
%game.aliases.settings = ["S", "Settings", "3"]; % Has been removed to meet deadline.
game.aliases.quit = ["Q", "Quit", "Quit Game", "3"];
%game.aliases.travel = ["T", "Travel", "1"]; % Has been removed to meet deadline.
game.aliases.doWork = ["D", "Do", "W", "Work", "Do Work", "1"];
game.aliases.progressTime = ["P", "Pt", "T", "Progress", "Time", "Progress Time", "2"];
game.aliases.plow = ["P", "Plow"];
game.aliases.harvest = ["H", "Harvest"];
game.aliases.plant = ["P", "Plant"];

game.maxSaveSlots = 10;
game.cropTypes = ["Wheat", "Corn", "Soybean", "Grass", "Carrot", "Sorghum", "Potato"];
game.cropValues = [20, 35, 40, 30, 50, 40, 100];
game.cropData = containers.Map(lower(game.cropTypes), game.cropValues);
game.fieldStates = ["Grown", "Plowed", "Planted", "Harvested"];

function [] = main(game)

    clc

    disp('------------------- Farming Simulator -------------------');
    disp('------ Load Game ------ New Game ------ Quit Game -------')

    newLine(); % Function that just return fprintf('\n'), this looks cleaner and will likely be a little more optimized.

    userChoice = input('Input: ','s');

    if any(strcmpi(game.aliases.load, userChoice))
        
        % [ Everything below this line is Loading player data ] %

        [game, success] = loadGame(game, false);

        if ~ success
            main(game);
        elseif success
            actionMenu(game);
        end

    elseif any(strcmpi(game.aliases.newGame, userChoice))

        % [ Everything below this line is creation of a new Savegame ] %

        [game, success] = loadGame(game, true);

        if ~ success
            main(game);
        elseif success
            disp('Welcome to farming simulator!')
            input('Press enter to continue... ')
            clc
            disp('Would you like to see the tutorial, or do you know how to play?')
            newLine();
            ui1 = input('Input [Y/N]: ','s');

            if any(strcmpi(ui1, game.aliases.yes))

                clc

                disp('Welcome to Farming Simulator!')
                disp('What''s your name?')
                newLine();
                name = input('Your name: ','s');
                game.player.name = name;

                filename = game.player.data.name;
                playerData = game.player;
                save(filename, 'playerData')

                fprintf(['Welcome ' name '! Here you will learn the basics of the game! Click enter to continue...'])
                pause();

                newLine();
                input('When reading prompts, like "Do Work", you should type out the full word. They are not case sensitive. Click enter to continue...');
                newLine();
                disp('For example, your input line would look like this: ');
                newLine();
                disp('Input: do work   <----');
                newLine();
                input('Click enter to continue...');
                input('You will start with a fully grown field, with a random crop. You will need to harvest it in the field menu. Click enter to continue...');
                newLine();
                input('After a successful harvest, you will need to plow it to prepare for planting. Click enter to continue...');
                newLine();
                input('For this, you will simply type "plow" as your input. Click enter to continue...');
                newLine();
                input('After plowing, you will need to plant a new crop. You will have to pay approx. 1/4 of the total sale price up front for cost of seeds! Click enter to continue...');
                newLine();
                input('Once you have planted, you will need to progress time, which will become available to you once planting is complete. This will then grow the field to a grown state. Click enter to continue...');
                newLine();
                input('Then, you can now harvest once again to make money. Click enter to continue...');

                newLine();
                input('You are now ready to farm! Feel free to read above and click enter when you are ready to begin!');

            else

                disp('Great! First, we forgot to get your name! What is it?')
                newLine();
                name = input('Your name: ','s');
                game.player.name = name;

                filename = game.player.data.name;
                playerData = game.player;
                save(filename, 'playerData')

                fprintf(['Welcome ' name '! Your savegame will load shortly.'])
                pause(3);

            end

            actionMenu(game);
        end

    elseif any(strcmpi(game.aliases.quit, userChoice))
    else

        % [ Everything below this line means the player did not have a valid entry ] %

        newLine();
        input('Sorry, your input was invalid. Click enter to reset. ');

        main(game);

    end

end

main(game);

function [] = actionMenu(game) % My tummy hurts.

    clc

    disp('Action Menu:');
    fprintf('%s''s savegame - $%.0f - %.0f reputation\n', game.player.name, game.player.data.cash, game.player.data.reputation);
    disp('--- Do Work --- Quit Game ---');
    newLine();
    
    userChoice = input('Input: ','s');

    if any(strcmpi(game.aliases.doWork, userChoice))

        clc

        disp('--- What would you like to do? ---')

        newline();

        fprintf('1.) Work a field\n\n');
        workChoice = input('Input: ','s');

        %disp(workChoice)

        if any(strcmpi(workChoice, ["Work a field", "Field", "1"]))

            fieldCount = game.player.data.fieldCount;

            if fieldCount <= 1
                clc

                fprintf('--- Your Field --- (%s - %s)\n\n', game.player.data.fields.field1.cropType, game.player.data.fields.field1.fieldState);
                disp(game.player.data.fields.field1.matrix)

                if game.player.data.fields.field1.fieldState == "Grown"

                    fprintf('What would you like to do?\n--- Harvest --- Plow --- Back ---\n');

                    workChoice2 = input('Input: ','s');

                    if any(strcmpi(workChoice2, ["H", "Harvest"]))

                        clc

                        disp('--- Harvesting. ---');

                        pause(0.5);

                        clc
                        disp('--- Harvesting. ---');

                        pause(0.5);

                        clc
                        disp('--- Harvesting.. ---');

                        pause(0.5);

                        clc
                        disp('--- Harvesting... ---');

                        pause(0.5);

                        clc
                    
                        harvestIncome = 25 * game.cropData(lower(game.player.data.fields.field1.cropType));

                        fprintf('You got %.0f cash from your harvest!\n\n', harvestIncome);

                        game.player.data.cash = game.player.data.cash + harvestIncome;
                        game.player.data.fields.field1.fieldState = "Harvested";

                        game.player.data.fields.field1.matrix = zeros([5 5]);

                        filename = game.player.data.name;
                        playerData = game.player;
                        save(filename, 'playerData')

                        input('Click enter to return to action menu... ');

                        actionMenu(game);

                    elseif any(strcmpi(workChoice2, ["P", "Plow"]))

                        fprintf('Are you sure you want to plow this field? This field currently ready to harvest with %s(s), and it will cost you to replant it.\n', game.player.data.fields.field1.cropType);
                        verification = input('Input [Y/N]: ', 's');

                        if strcmpi(verification, 'Y')

                            game.player.data.fields.field1.fieldState = "Plowed";
                            game.player.data.fields.field1.cropType = "None";
                            game.player.data.fields.field1.matrix = zeros([5 5]);

                            filename = game.player.data.name;
                            playerData = game.player;
                            save(filename, 'playerData')

                            input('Plowing complete! Click enter to return to action menu...');
                            actionMenu(game);

                        else

                            input('Okay, click enter to return to action menu...');
                            actionMenu(game);

                        end

                    elseif any(strcmpi(workChoice2, ["B", "Back"]))

                        actionMenu(game);

                    else

                        input('Sorry, your input was invalid. Click enter to return to action menu...');
                        actionMenu(game);

                    end

                elseif game.player.data.fields.field1.fieldState == "Plowed"

                    fprintf('What would you like to do?\n--- Plant --- Back ---\n\n');

                    workChoice2 = input('Input: ','s');

                    if any(strcmpi(workChoice2, ["P", "Plant"]))

                        clc
                        cropChoice = lower(input('What crop would you like to plant? Type help for a list of crops: ','s'));

                        while ~ any(strcmpi(cropChoice, game.cropTypes)) || strcmpi(cropChoice, 'Help')
                            
                            clc
                            disp(game.cropTypes);
                            cropChoice = lower(input('What crop would you like to plant? ','s'));

                        end

                        if any(strcmpi(cropChoice, game.cropTypes))

                            priceToPlant = 0.25 * game.cropData(cropChoice) * 25;

                            fprintf('This crop will cost you $%.0f to plant. Do you still want to plant it?\n', priceToPlant);
                            userChoice3 = input('Input [Y/N]: ','s');
                            canAfford = priceToPlant < game.player.data.cash;

                            if strcmpi(userChoice3, 'Y') && canAfford

                                clc
                                fprintf('Planting crop.\n');

                                pause(0.5);

                                clc
                                fprintf('Planting crop..\n');

                                pause(0.5);

                                clc
                                fprintf('Planting crop...\n');

                                pause(0.5);

                                game.player.data.fields.field1.cropType = replaceBetween(cropChoice, 1, 1, upper(extractBetween(lower(cropChoice), 1, 1)));
                                game.player.data.fields.field1.fieldState = "Growing";
                                game.player.data.fields.field1.matrix = ones([5 5]);

                                game.player.data.cash = game.player.data.cash - priceToPlant;

                                filename = game.player.data.name;
                                playerData = game.player;
                                save(filename, 'playerData')

                                clc
                                input('Planting complete! Click enter to return to action menu...');
                                actionMenu(game);

                            elseif ~ canAfford

                                disp('Sorry, you can''t afford this seed.');
                                newLine();
                                input('Click enter to return to action menu...');
                                actionMenu(game);

                            else
                                
                                input('Okay, click enter to return to action menu...');
                                actionMenu(game);

                            end

                        end

                    elseif any(strcmpi(workChoice2, ["B", "Back"]))

                        actionMenu(game);

                    else

                        input('Sorry, your input was invalid. Click enter to return to action menu...');
                        actionMenu(game);

                    end

                elseif game.player.data.fields.field1.fieldState == "Harvested"

                    fprintf('What would you like to do?\n--- Plow --- Back ---\n\n');

                    workChoice2 = input('Input: ','s');

                    if any(strcmpi(workChoice2, ["P", "Plow"]))

                        game.player.data.fields.field1.fieldState = "Plowed";
                        game.player.data.fields.field1.cropType = "None";
                        game.player.data.fields.field1.matrix = zeros([5 5]);

                        filename = game.player.data.name;
                        playerData = game.player;
                        save(filename, 'playerData')

                        input('Plowing complete! Click enter to return to action menu...');
                        actionMenu(game);

                    elseif any(strcmpi(workChoice2, ["B", "Back"]))

                        actionMenu(game);

                    else

                        input('Sorry, your input was invalid. Click enter to return to action menu...');
                        actionMenu(game);

                    end

                elseif game.player.data.fields.field1.fieldState == "Growing"

                    fprintf('What would you like to do?\n--- Plow --- Progress Time --- Back ---\n\n');

                    workChoice2 = input('Input: ','s');

                    if any(strcmpi(workChoice2, ["P", "Plow"]))

                        fprintf('Are you sure you want to plow this field? This field currently growing %s(s), and it will cost you to replant it.\n', game.player.data.fields.field1.cropType);
                        verification = input('Input [Y/N]: ', 's');

                        if any(strcmpi(verification, ["Y", "Yes"]))

                            game.player.data.fields.field1.fieldState = "Plowed";
                            game.player.data.fields.field1.cropType = "None";
                            game.player.data.fields.field1.matrix = zeros([5 5]);

                            filename = game.player.data.name;
                            playerData = game.player;
                            save(filename, 'playerData')

                            input('Plowing complete! Click enter to return to action menu...');
                            actionMenu(game);

                        else

                            input('Okay, click enter to return to action menu...');
                            actionMenu(game);

                        end

                    elseif any(strcmpi(workChoice2, ["PT", "Progress", "Progress Time", "Time"]))

                        clc
                        fprintf('Progressing time.\n');

                        pause(1);

                        clc
                        fprintf('Progressing time..\n');

                        pause(1);

                        clc
                        fprintf('Progressing time...\n');

                        pause(1);

                        clc
                        fprintf('Progressing time.\n');

                        pause(1);

                        clc
                        fprintf('Progressing time..\n');

                        pause(1);

                        clc
                        fprintf('Progressing time...\n');

                        pause(1);

                        game.player.data.fields.field1.fieldState = "Grown";

                        filename = game.player.data.name;
                        playerData = game.player;
                        save(filename, 'playerData')

                        input('Time progressed! Click enter to return to action menu...');
                        actionMenu(game);

                    elseif any(strcmpi(workChoice2, ["B", "Back"]))

                        actionMenu(game);

                    else

                        input('Sorry, your input was invalid. Click enter to return to action menu...');
                        actionMenu(game);

                    end

                else

                    newLine();

                    input('Sorry, your input was invalid. Click enter to return to action menu...');

                    actionMenu(game);

                end

            else

            end

        else

            newLine();

            input('Sorry, your input was invalid. Click enter to return to action menu...');

            actionMenu(game);

        end

    elseif any(strcmpi(game.aliases.quit, userChoice))

        clc
        fprintf('You are now quitting the game! Your data will be saved under %s.\n', game.player.data.name);
        input('Click enter to finish quitting.');

    else

        newLine();

        input('Sorry, your input was invalid. Click enter to return to action menu...');

        actionMenu(game);

    end

end
