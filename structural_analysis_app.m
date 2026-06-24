classdef app1_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        Label_3                        matlab.ui.control.Label
        Label_2                        matlab.ui.control.Label
        Label                          matlab.ui.control.Label
        NumberofElementsinTOTALEditFieldLabel  matlab.ui.control.Label
        DirectionofForceDropDownLabel  matlab.ui.control.Label
        SUBMITSUPPORTINFOButton        matlab.ui.control.Button
        TypeofSupportDropDown          matlab.ui.control.DropDown
        TypeofSupportDropDownLabel     matlab.ui.control.Label
        YoungsModulusEditFieldLabel    matlab.ui.control.Label
        AreaofCrossSectionEditFieldLabel  matlab.ui.control.Label
        ForcesValueEditFieldLabel      matlab.ui.control.Label
        YCoordinateEditFieldLabel      matlab.ui.control.Label
        XCoordinateEditFieldLabel      matlab.ui.control.Label
        NodeNumberEditField_3          matlab.ui.control.NumericEditField
        NodeNumberEditField_3Label     matlab.ui.control.Label
        NodeNumberEditField_2Label     matlab.ui.control.Label
        SUBMITALLButton                matlab.ui.control.Button
        SUBMITPropertiesButton         matlab.ui.control.Button
        NumberofElementsinTOTALEditField  matlab.ui.control.NumericEditField
        YoungsModulusEditField         matlab.ui.control.NumericEditField
        AreaofCrossSectionEditField    matlab.ui.control.NumericEditField
        ElementNumberEditField         matlab.ui.control.NumericEditField
        ElementNumberEditFieldLabel    matlab.ui.control.Label
        SUBMITFORCEButton              matlab.ui.control.Button
        DirectionofForceDropDown       matlab.ui.control.DropDown
        ForcesValueEditField           matlab.ui.control.NumericEditField
        NodeNumberEditField_2          matlab.ui.control.NumericEditField
        SUBMITCOORDINATESButton        matlab.ui.control.Button
        YCoordinateEditField           matlab.ui.control.NumericEditField
        XCoordinateEditField           matlab.ui.control.NumericEditField
        NodeNumberEditField            matlab.ui.control.NumericEditField
        NodeNumberEditFieldLabel       matlab.ui.control.Label
        NumberofNodesinTOTALEditField  matlab.ui.control.NumericEditField
        NumberofNodesinTOTALEditFieldLabel  matlab.ui.control.Label
        ForcesactingonNodesLabel       matlab.ui.control.Label
        SupportsinStructurewrtNodeLabel  matlab.ui.control.Label
        GeometricPropertiesLabel       matlab.ui.control.Label
        NodeCoordinatesLabel           matlab.ui.control.Label
        STRUCTURALANALYSISLabel        matlab.ui.control.Label
    end

    
    properties (Access = private)
        Property % Description
        num_nodes
        xcood
        ycood
        nodecood
        arr
        nodef
        forceval
        dropdownf
        force = zeros(2*num_nodes,1)
        elem
        totalelem
        area = zeros(numel,1)
        ymod = zeros(numel,1)
        supportnum
        displacement = ones(2*num_nodes,1)
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: NumberofNodesinTOTALEditField
        function NumberofNodesinTOTALEditFieldValueChanged(app, event)
            value = app.NumberofNodesinTOTALEditField.Value;
            app.num_nodes = value;
        end

        % Value changed function: XCoordinateEditField
        function XCoordinateEditFieldValueChanged(app, event)
            value = app.XCoordinateEditField.Value;
            app.xcood=value;
        end

        % Value changed function: YCoordinateEditField
        function YCoordinateEditFieldValueChanged(app, event)
            value = app.YCoordinateEditField.Value;
            app.ycood=value;
        end

        % Button pushed function: SUBMITCOORDINATESButton
        function SUBMITCOORDINATESButtonPushed(app, event)
            app.arr(app.nodecood,1)=app.xcood;
            app.arr(app.nodecood,2)=app.ycood;

        end

        % Value changed function: NodeNumberEditField
        function NodeNumberEditFieldValueChanged(app, event)
            value = app.NodeNumberEditField.Value;
            app.nodecood = value;
        end

        % Value changed function: NodeNumberEditField_2
        function NodeNumberEditField_2ValueChanged(app, event)
            value = app.NodeNumberEditField_2.Value;
            app.nodef= value;
        end

        % Value changed function: ForcesValueEditField
        function ForcesValueEditFieldValueChanged(app, event)
            value = app.ForcesValueEditField.Value;
            app.forceval = value;
        end

        % Button pushed function: SUBMITFORCEButton
        function SUBMITFORCEButtonPushed(app, event)
            switch app.DirectionofForceDropDown.Value
                case 'Horizontal'
                    app.force(((app.nodef)*2)-1) = app.forceval;
                otherwise
                    app.force((app.nodef)*2) = app.forceval;
            end
        end

        % Value changed function: ElementNumberEditField
        function ElementNumberEditFieldValueChanged(app, event)
            value = app.ElementNumberEditField.Value;
            app.elem = value;
        end

        % Button pushed function: SUBMITPropertiesButton
        function SUBMITPropertiesButtonPushed(app, event)
            app.area(app.elem)=app.AreaofCrossSectionEditField.Value;
            app.ymod(app.elem)=app.YoungsModulusEditField.Value;

        end

        % Value changed function: NumberofElementsinTOTALEditField
        function NumberofElementsinTOTALEditFieldValueChanged(app, event)
            value = app.NumberofElementsinTOTALEditField.Value;
            app.totalelem = value;
        end

        % Button pushed function: SUBMITALLButton
        function SUBMITALLButtonPushed(app, event)
            for i = 1:app.totalelem
                app.area(i)=app.AreaofCrossSectionEditField.Value;
                app.ymod(i)=app.YoungsModulusEditField.Value;
            end
        end

        % Value changed function: NodeNumberEditField_3
        function NodeNumberEditField_3ValueChanged(app, event)
            value = app.NodeNumberEditField_3.Value;
            app.supportnum = value;
        end

        % Button pushed function: SUBMITSUPPORTINFOButton
        function SUBMITSUPPORTINFOButtonPushed(app, event)
            switch app.TypeofSupportDropDown.Value
                case 'Roller Joint'
                    app.displacement((app.supportnum)*2) = 0;
                otherwise
                    app.displacement(((app.supportnum)*2)-1) = 0;
                    app.displacement((app.supportnum)*2) = 0;
            end

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.7608 0.898 0.949];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create STRUCTURALANALYSISLabel
            app.STRUCTURALANALYSISLabel = uilabel(app.UIFigure);
            app.STRUCTURALANALYSISLabel.FontName = 'Georgia';
            app.STRUCTURALANALYSISLabel.FontSize = 24;
            app.STRUCTURALANALYSISLabel.FontWeight = 'bold';
            app.STRUCTURALANALYSISLabel.Position = [158 440 327 32];
            app.STRUCTURALANALYSISLabel.Text = 'STRUCTURAL ANALYSIS';

            % Create NodeCoordinatesLabel
            app.NodeCoordinatesLabel = uilabel(app.UIFigure);
            app.NodeCoordinatesLabel.FontWeight = 'bold';
            app.NodeCoordinatesLabel.Position = [58 371 109 22];
            app.NodeCoordinatesLabel.Text = 'Node Coordinates';

            % Create GeometricPropertiesLabel
            app.GeometricPropertiesLabel = uilabel(app.UIFigure);
            app.GeometricPropertiesLabel.FontWeight = 'bold';
            app.GeometricPropertiesLabel.Position = [391 371 128 22];
            app.GeometricPropertiesLabel.Text = 'Geometric Properties';

            % Create SupportsinStructurewrtNodeLabel
            app.SupportsinStructurewrtNodeLabel = uilabel(app.UIFigure);
            app.SupportsinStructurewrtNodeLabel.FontWeight = 'bold';
            app.SupportsinStructurewrtNodeLabel.Position = [360 165 188 22];
            app.SupportsinStructurewrtNodeLabel.Text = 'Supports in Structure w.r.t Node';

            % Create ForcesactingonNodesLabel
            app.ForcesactingonNodesLabel = uilabel(app.UIFigure);
            app.ForcesactingonNodesLabel.FontWeight = 'bold';
            app.ForcesactingonNodesLabel.Position = [47 163 141 22];
            app.ForcesactingonNodesLabel.Text = 'Forces acting on Nodes';

            % Create NumberofNodesinTOTALEditFieldLabel
            app.NumberofNodesinTOTALEditFieldLabel = uilabel(app.UIFigure);
            app.NumberofNodesinTOTALEditFieldLabel.HorizontalAlignment = 'right';
            app.NumberofNodesinTOTALEditFieldLabel.Position = [44 409 153 22];
            app.NumberofNodesinTOTALEditFieldLabel.Text = 'Number of Nodes in TOTAL';

            % Create NumberofNodesinTOTALEditField
            app.NumberofNodesinTOTALEditField = uieditfield(app.UIFigure, 'numeric');
            app.NumberofNodesinTOTALEditField.ValueChangedFcn = createCallbackFcn(app, @NumberofNodesinTOTALEditFieldValueChanged, true);
            app.NumberofNodesinTOTALEditField.Position = [212 409 19 22];

            % Create NodeNumberEditFieldLabel
            app.NodeNumberEditFieldLabel = uilabel(app.UIFigure);
            app.NodeNumberEditFieldLabel.HorizontalAlignment = 'right';
            app.NodeNumberEditFieldLabel.FontName = 'Times New Roman';
            app.NodeNumberEditFieldLabel.Position = [59 341 73 22];
            app.NodeNumberEditFieldLabel.Text = 'Node Number';

            % Create NodeNumberEditField
            app.NodeNumberEditField = uieditfield(app.UIFigure, 'numeric');
            app.NodeNumberEditField.ValueChangedFcn = createCallbackFcn(app, @NodeNumberEditFieldValueChanged, true);
            app.NodeNumberEditField.FontName = 'Times New Roman';
            app.NodeNumberEditField.Position = [147 341 19 22];

            % Create XCoordinateEditField
            app.XCoordinateEditField = uieditfield(app.UIFigure, 'numeric');
            app.XCoordinateEditField.ValueChangedFcn = createCallbackFcn(app, @XCoordinateEditFieldValueChanged, true);
            app.XCoordinateEditField.FontName = 'Times New Roman';
            app.XCoordinateEditField.Position = [147 309 19 22];

            % Create YCoordinateEditField
            app.YCoordinateEditField = uieditfield(app.UIFigure, 'numeric');
            app.YCoordinateEditField.ValueChangedFcn = createCallbackFcn(app, @YCoordinateEditFieldValueChanged, true);
            app.YCoordinateEditField.FontName = 'Times New Roman';
            app.YCoordinateEditField.Position = [147 278 19 22];

            % Create SUBMITCOORDINATESButton
            app.SUBMITCOORDINATESButton = uibutton(app.UIFigure, 'push');
            app.SUBMITCOORDINATESButton.ButtonPushedFcn = createCallbackFcn(app, @SUBMITCOORDINATESButtonPushed, true);
            app.SUBMITCOORDINATESButton.Position = [42 241 147 25];
            app.SUBMITCOORDINATESButton.Text = 'SUBMIT COORDINATES';

            % Create NodeNumberEditField_2
            app.NodeNumberEditField_2 = uieditfield(app.UIFigure, 'numeric');
            app.NodeNumberEditField_2.ValueChangedFcn = createCallbackFcn(app, @NodeNumberEditField_2ValueChanged, true);
            app.NodeNumberEditField_2.FontName = 'Times';
            app.NodeNumberEditField_2.Position = [146 141 19 22];

            % Create ForcesValueEditField
            app.ForcesValueEditField = uieditfield(app.UIFigure, 'numeric');
            app.ForcesValueEditField.ValueChangedFcn = createCallbackFcn(app, @ForcesValueEditFieldValueChanged, true);
            app.ForcesValueEditField.Position = [144 112 19 22];

            % Create DirectionofForceDropDown
            app.DirectionofForceDropDown = uidropdown(app.UIFigure);
            app.DirectionofForceDropDown.Items = {'Horizontal', 'Vertical'};
            app.DirectionofForceDropDown.Position = [138 81 100 22];
            app.DirectionofForceDropDown.Value = 'Horizontal';

            % Create SUBMITFORCEButton
            app.SUBMITFORCEButton = uibutton(app.UIFigure, 'push');
            app.SUBMITFORCEButton.ButtonPushedFcn = createCallbackFcn(app, @SUBMITFORCEButtonPushed, true);
            app.SUBMITFORCEButton.Position = [42 47 147 25];
            app.SUBMITFORCEButton.Text = 'SUBMIT FORCE';

            % Create ElementNumberEditFieldLabel
            app.ElementNumberEditFieldLabel = uilabel(app.UIFigure);
            app.ElementNumberEditFieldLabel.HorizontalAlignment = 'right';
            app.ElementNumberEditFieldLabel.FontName = 'Times';
            app.ElementNumberEditFieldLabel.Position = [394 341 87 22];
            app.ElementNumberEditFieldLabel.Text = 'Element Number';

            % Create ElementNumberEditField
            app.ElementNumberEditField = uieditfield(app.UIFigure, 'numeric');
            app.ElementNumberEditField.ValueChangedFcn = createCallbackFcn(app, @ElementNumberEditFieldValueChanged, true);
            app.ElementNumberEditField.Position = [496 341 19 22];

            % Create AreaofCrossSectionEditField
            app.AreaofCrossSectionEditField = uieditfield(app.UIFigure, 'numeric');
            app.AreaofCrossSectionEditField.Position = [505 310 19 22];

            % Create YoungsModulusEditField
            app.YoungsModulusEditField = uieditfield(app.UIFigure, 'numeric');
            app.YoungsModulusEditField.Position = [494 278 19 22];

            % Create NumberofElementsinTOTALEditField
            app.NumberofElementsinTOTALEditField = uieditfield(app.UIFigure, 'numeric');
            app.NumberofElementsinTOTALEditField.ValueChangedFcn = createCallbackFcn(app, @NumberofElementsinTOTALEditFieldValueChanged, true);
            app.NumberofElementsinTOTALEditField.Position = [532 409 19 22];

            % Create SUBMITPropertiesButton
            app.SUBMITPropertiesButton = uibutton(app.UIFigure, 'push');
            app.SUBMITPropertiesButton.ButtonPushedFcn = createCallbackFcn(app, @SUBMITPropertiesButtonPushed, true);
            app.SUBMITPropertiesButton.Position = [333 241 122 25];
            app.SUBMITPropertiesButton.Text = 'SUBMIT Properties';

            % Create SUBMITALLButton
            app.SUBMITALLButton = uibutton(app.UIFigure, 'push');
            app.SUBMITALLButton.ButtonPushedFcn = createCallbackFcn(app, @SUBMITALLButtonPushed, true);
            app.SUBMITALLButton.Position = [466 241 122 25];
            app.SUBMITALLButton.Text = 'SUBMIT ALL';

            % Create NodeNumberEditField_2Label
            app.NodeNumberEditField_2Label = uilabel(app.UIFigure);
            app.NodeNumberEditField_2Label.HorizontalAlignment = 'right';
            app.NodeNumberEditField_2Label.FontName = 'Times';
            app.NodeNumberEditField_2Label.Position = [58 141 73 22];
            app.NodeNumberEditField_2Label.Text = 'Node Number';

            % Create NodeNumberEditField_3Label
            app.NodeNumberEditField_3Label = uilabel(app.UIFigure);
            app.NodeNumberEditField_3Label.HorizontalAlignment = 'right';
            app.NodeNumberEditField_3Label.FontName = 'Times';
            app.NodeNumberEditField_3Label.Position = [401 135 73 22];
            app.NodeNumberEditField_3Label.Text = 'Node Number';

            % Create NodeNumberEditField_3
            app.NodeNumberEditField_3 = uieditfield(app.UIFigure, 'numeric');
            app.NodeNumberEditField_3.ValueChangedFcn = createCallbackFcn(app, @NodeNumberEditField_3ValueChanged, true);
            app.NodeNumberEditField_3.FontName = 'Times';
            app.NodeNumberEditField_3.Position = [489 135 19 22];

            % Create XCoordinateEditFieldLabel
            app.XCoordinateEditFieldLabel = uilabel(app.UIFigure);
            app.XCoordinateEditFieldLabel.HorizontalAlignment = 'right';
            app.XCoordinateEditFieldLabel.FontName = 'Times New Roman';
            app.XCoordinateEditFieldLabel.Position = [62 309 70 22];
            app.XCoordinateEditFieldLabel.Text = 'X Coordinate';

            % Create YCoordinateEditFieldLabel
            app.YCoordinateEditFieldLabel = uilabel(app.UIFigure);
            app.YCoordinateEditFieldLabel.HorizontalAlignment = 'right';
            app.YCoordinateEditFieldLabel.FontName = 'Times New Roman';
            app.YCoordinateEditFieldLabel.Position = [62 278 70 22];
            app.YCoordinateEditFieldLabel.Text = 'Y Coordinate';

            % Create ForcesValueEditFieldLabel
            app.ForcesValueEditFieldLabel = uilabel(app.UIFigure);
            app.ForcesValueEditFieldLabel.HorizontalAlignment = 'right';
            app.ForcesValueEditFieldLabel.FontName = 'Times';
            app.ForcesValueEditFieldLabel.Position = [62 112 67 22];
            app.ForcesValueEditFieldLabel.Text = 'Forces Value';

            % Create AreaofCrossSectionEditFieldLabel
            app.AreaofCrossSectionEditFieldLabel = uilabel(app.UIFigure);
            app.AreaofCrossSectionEditFieldLabel.HorizontalAlignment = 'right';
            app.AreaofCrossSectionEditFieldLabel.FontName = 'Times';
            app.AreaofCrossSectionEditFieldLabel.Position = [379 309 111 22];
            app.AreaofCrossSectionEditFieldLabel.Text = 'Area of Cross Section';

            % Create YoungsModulusEditFieldLabel
            app.YoungsModulusEditFieldLabel = uilabel(app.UIFigure);
            app.YoungsModulusEditFieldLabel.HorizontalAlignment = 'right';
            app.YoungsModulusEditFieldLabel.FontName = 'Times';
            app.YoungsModulusEditFieldLabel.Position = [390 278 89 22];
            app.YoungsModulusEditFieldLabel.Text = 'Young''s Modulus';

            % Create TypeofSupportDropDownLabel
            app.TypeofSupportDropDownLabel = uilabel(app.UIFigure);
            app.TypeofSupportDropDownLabel.HorizontalAlignment = 'right';
            app.TypeofSupportDropDownLabel.FontName = 'Times';
            app.TypeofSupportDropDownLabel.Position = [358 102 83 22];
            app.TypeofSupportDropDownLabel.Text = 'Type of Support';

            % Create TypeofSupportDropDown
            app.TypeofSupportDropDown = uidropdown(app.UIFigure);
            app.TypeofSupportDropDown.Items = {'Roller Joint', 'Pin Joint'};
            app.TypeofSupportDropDown.FontName = 'Times';
            app.TypeofSupportDropDown.Position = [456 102 100 22];
            app.TypeofSupportDropDown.Value = 'Roller Joint';

            % Create SUBMITSUPPORTINFOButton
            app.SUBMITSUPPORTINFOButton = uibutton(app.UIFigure, 'push');
            app.SUBMITSUPPORTINFOButton.ButtonPushedFcn = createCallbackFcn(app, @SUBMITSUPPORTINFOButtonPushed, true);
            app.SUBMITSUPPORTINFOButton.Position = [382 61 151 25];
            app.SUBMITSUPPORTINFOButton.Text = 'SUBMIT SUPPORT INFO';

            % Create DirectionofForceDropDownLabel
            app.DirectionofForceDropDownLabel = uilabel(app.UIFigure);
            app.DirectionofForceDropDownLabel.HorizontalAlignment = 'right';
            app.DirectionofForceDropDownLabel.FontName = 'Times';
            app.DirectionofForceDropDownLabel.Position = [29 81 94 22];
            app.DirectionofForceDropDownLabel.Text = 'Direction of Force';

            % Create NumberofElementsinTOTALEditFieldLabel
            app.NumberofElementsinTOTALEditFieldLabel = uilabel(app.UIFigure);
            app.NumberofElementsinTOTALEditFieldLabel.HorizontalAlignment = 'right';
            app.NumberofElementsinTOTALEditFieldLabel.Position = [350 409 167 22];
            app.NumberofElementsinTOTALEditFieldLabel.Text = 'Number of Elements in TOTAL';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontName = 'Times';
            app.Label.Position = [29 199 257 30];
            app.Label.Text = {'X&Y coordinates to be distance from Origin Node '; '(Maintain the same units throughout)'};

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.FontName = 'Times';
            app.Label_2.Position = [298 199 344 30];
            app.Label_2.Text = {'Use Submit all if geometric properties '; 'are the same for all the values'};

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.FontName = 'Times';
            app.Label_3.Position = [5 -3 518 30];
            app.Label_3.Text = 'Submit the individual node or element properties for all sections and repeat for the next nodes/elements';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app1_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
