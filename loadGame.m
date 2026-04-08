function [game, success] = loadGame(game, newSave)

    clc

    if newSave % Creating a new savegame instead of loading it.

        filename = 'Savegame1.mat';

        if isfile(filename)
            
            % [ Anything below this line means that a file already exists at this location with this name ] %

            for i = 2:1:game.maxSaveSlots
                
                filename = ['Savegame' num2str(i) '.mat'];

                if ~ isfile(filename)
    
                    game.player.data.name = filename;

                    game.player.data.fields.field1 = struct();
                    game.player.data.fields.field1.name = "Field 1";
                    
                    cropType = game.cropTypes(randi([1, numel(game.cropTypes)]));
                    game.player.data.fields.field1.cropType = cropType;
                    game.player.data.fields.field1.fieldState = "Grown";

                    game.player.data.fields.field1.matrix = ones([5 5]);

                    game.player.data.fieldCount = 1;

                    playerData = game.player;
                    save(filename, 'playerData')
                    success = true;
                    return;

                elseif isfile(filename) && i == game.maxSaveSlots

                    disp('Sorry, but you have reached the max number of save slots. Delete some to keep playing new slots!')
                    newLine();
                    input('Click enter to return to the menu...');
                    success = false;
                    return;

                end
            end

        else

            game.player.data.name = filename;
            game.player.data.fields.field1 = struct();
            game.player.data.fields.field1.name = "Field 1";
                    
            cropType = game.cropTypes(randi([1, numel(game.cropTypes)]));
            game.player.data.fields.field1.cropType = cropType;
            game.player.data.fields.field1.fieldState = "Grown";

            game.player.data.fields.field1.matrix = ones([5 5]);

            game.player.data.fieldCount = 1;

            playerData = game.player;
            save(filename, 'playerData')
            success = true;
            return;

        end

    elseif ~ newSave % This is loading a savegame instead of creating it

        [file, path] = uigetfile('*.mat', 'Select a save file');

        while file == 0
        
            ui1 = input('Did you mean to do that [y/n]: ','s');

            if strcmpi(ui1, 'y')

                disp('Returning to menu...')
                pause(3);
                success = false;
                return;
                
            elseif strcmpi(ui1, 'n')

                [file, path] = uigetfile('*.mat', 'Select a save file');

            end

        end

        load(file);
        game.player = playerData;

        success = true;

    end

end
