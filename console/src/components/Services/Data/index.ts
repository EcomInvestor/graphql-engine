/**
 *  Point of contact for component modules
 *
 *  ie: import { CounterButton, InfoBar } from 'components';
 *
 */

import dataPageConnector from './DataPageContainer';
import PageContainer from './DataSubSidebar';
import viewTableConnector from './TableBrowseRows/ViewTable';
import addExistingTableViewConnector from './Add/AddExistingTableView';
import addTableConnector from './Add/AddTable';
import rawSQLConnector from './RawSQL/RawSQL';
import permissionsSummaryConnector from './PermissionsSummary/PermissionsSummary';
import modifyViewConnector from './TableModify/ModifyView';
import relationshipsConnector from './TableRelationships/Relationships';
import relationshipsViewConnector from './TableRelationships/RelationshipsView';
import permissionsConnector from './TablePermissions/Permissions';
import schemaConnector from './Schema/Schema';
import migrationsConnector from './Migrations/Migrations';
import dataRouterUtils from './DataRouter';
import dataReducer from './DataReducer';
import functionWrapperConnector from './Function/FunctionWrapper';
import ModifyCustomFunction from './Function/Modify/ModifyCustomFunction';
import FunctionPermissions from './Function/Permission/Permission';
import ConnectedDatabaseManagePage from './Schema/ManageDatabase';
import ConnectedCreateDataSourcePage from './DataSources/CreateDataSource';
import { useIsUnmounted } from './Common/tsUtils';

export {
  dataPageConnector,
  PageContainer,
  viewTableConnector,
  addExistingTableViewConnector,
  addTableConnector,
  rawSQLConnector,
  permissionsSummaryConnector,
  modifyViewConnector,
  relationshipsConnector,
  relationshipsViewConnector,
  permissionsConnector,
  schemaConnector,
  migrationsConnector,
  dataRouterUtils,
  dataReducer,
  functionWrapperConnector,
  ModifyCustomFunction,
  FunctionPermissions,
  ConnectedDatabaseManagePage,
  ConnectedCreateDataSourcePage,
  useIsUnmounted,
};
